require 'aws/s3'

desc "Create a backup of the producation database"
task :backup => :environment do
  backup
end

desc "Grab the latest db snapshot and recreate the local development db"
task 'db:pull' do
  connect
  backup_file = "/tmp/flowfeeds_newest_dump.sql.gz"
  bucket = AWS::S3::Bucket.find('flowfeeds_dbs')
  newest = bucket.objects.sort { |a,b| b.last_modified <=> a.last_modified }.first
  open(backup_file, 'w') do |file|
    file.write newest.value.force_encoding('UTF-8')
  end
  sh "dropdb flowfeeds_development && createdb flowfeeds_development  -O flowfeeds"
  sh "gunzip -c #{backup_file} | psql flowfeeds_development"
end

def connect
  AWS::S3::Base.establish_connection!(
    access_key_id: ENV.fetch("S3_KEY"),
    secret_access_key: ENV.fetch("S3_SEC")
  )
end

def send_to_amazon(file_path)
  bucket = "flowfeeds_dbs"
  file_name = File.basename(file_path)
  connect
  AWS::S3::S3Object.store(file_name,File.open("#{file_path}"), bucket)
end

def backup
  datestamp = Time.now.strftime("%Y-%m-%d")
  backup_file = "/tmp/flowfeeds_#{datestamp}_dump.sql.gz"
  sh "pg_dump -U flowfeeds flowfeeds_production | gzip -c > #{backup_file}"
  send_to_amazon backup_file
  File.delete backup_file
end

