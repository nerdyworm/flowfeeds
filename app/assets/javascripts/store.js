Flowfeeds.Store = Ember.Object.extend({
  find: function(type, id) {
    var bucket = this.bucketForType(type);
    return bucket[id.toString()];
  },

  load: function(type, params) {
    var bucket = this.bucketForType(type),
        id     = params.id.toString(),
        model  = null;

    if(bucket[id]) {
      model = bucket[id];
    } else {
      model = bucket[id] = type.create();
    }

    model.setProperties(params);

    return model;
  },

  bucketForType: function(type) {
    var name = type.toString().split(".")[1];

    if('undefined' === typeof this.get(name)) {
      this.set(name, {});
    }

    return this.get(name);
  },

  loadMany: function(type, array) {
    return array.map(function(record) {
      return this.load(type, record);
    }, this);
  }
});

Flowfeeds.store = Flowfeeds.Store.create();
