translations = {
  en: {
    hello: 'Hello world',
    foo: {
      bar: {
        baz: 'Found me'
      }
    },
    pony: {
      one: 'pony',
      other: 'ponies'
    },
    welcome: 'Welcome, {{name}}!',
    forest_howto: {
      one: 'Go north {{count}} league until you see the tall cedars',
      other: 'Go north {{count}} leagues until you see the tall cedars'
    }
  },
  no: {
    hello: 'Hei verden'
  }
};

function setup(){
  I18n.translations = translations;
  I18n.locale = 'en';
};


describe('I18n.lookup', {

  before_each: function(){
    setup();
  },
  
  'should use keys array to build scope': function(){
    expect(I18n.lookup(['foo', 'bar', 'baz'])).should_be('Found me');
  },
  
  'should return all sub-translations if keys do not resolve to an end-node': function(){
    expect(I18n.lookup(['foo'])).should_be(translations.en.foo);
    expect(I18n.lookup(['foo']).bar.baz).should_be('Found me');
  },

  'should include locale key implicitly': function(){
    expect(I18n.lookup(['hello'])).should_be('Hello world');
  },

  'should return null when translation not found': function(){
    expect(I18n.lookup(['humbaba'])).should_be_null();
    expect(I18n.lookup(['utnapishtim', 'humbaba'])).should_be_null();
  },

  'should return default string if translation not found': function(){
    expect(I18n.lookup(['humbaba'], ['Protector of the Cedars'])).should_be('Protector of the Cedars');
    expect(I18n.lookup(['mountains', 'forest', 'humbaba'], ["Don't tread in my forest"])).should_be("Don't tread in my forest");
  },

  'should not care about default strings if key resolves to a translation': function(){
    expect(I18n.lookup(['foo', 'bar', 'baz'], ['IM IN UR TRANSLATION'])).should_be('Found me');
  },

  'should use default strings starting with ":" to do another lookup': function(){
    expect(I18n.lookup(['humbaba'], [':hello'])).should_be('Hello world');
    expect(I18n.lookup(['humbaba'], ['hello'])).should_be('hello');
    expect(I18n.lookup(['humbaba'], [':jello'])).should_be_null();
  },

  'should keep trying keys in the defaults array until it reaches the end or finds a match': function(){
    expect(I18n.lookup(['humbaba'], [':huwawa', ':hello'])).should_be('Hello world');
    expect(I18n.lookup(['humbaba'], [':huwawa', ':hawawa', ':howowo', 'The Terrible'])).should_be('The Terrible');
    expect(I18n.lookup(['humbaba'], [':huwawa', ':hawawa'])).should_be_null();
  }


});


describe('I18n.pluralize', {

  before_each: function(){
    setup();
  },

  'should return value.one when count is 1': function(){
    expect(I18n.pluralize(translations.en.pony, 1)).should_be('pony');
  },

  'should return value.other when count is not 1': function(){
    expect(I18n.pluralize(translations.en.pony, 3)).should_be('ponies');
  }

});


describe('I18n.translate', {

  before_each: function(){
    setup();
  },

  'should return the value from the translations object to which the key resolves': function(){
    expect(I18n.t('hello')).should_be('Hello world');
  },

  'should scope the lookup with the scope option': function(){
    expect(I18n.t('baz', {scope:['foo', 'bar']})).should_be('Found me');
  },

  'should allow dots as scope separators': function(){
    expect(I18n.t('foo.bar.baz')).should_be('Found me');
    expect(I18n.t('baz', {scope:'foo.bar'})).should_be('Found me');
  },

  'should return null when translation not found': function(){
    expect(I18n.t('humbaba')).should_be_null();
    expect(I18n.t('foo.bar.bar')).should_be_null();
  },

  'should return defaultValue option when key not found': function(){
    expect(I18n.t('humbaba', {defaultValue:'I <3 cedars'})).should_be('I <3 cedars');
  },

  'should use defaultValue to do another lookup if it starts with ":"': function(){
    expect(I18n.t('humbaba', {defaultValue:':hello'})).should_be('Hello world');
    expect(I18n.t('humbaba', {defaultValue:':spoon'})).should_be_null();
  },

  'should allow an array as defaultValue and keep trying to find a translation with the values in it': function(){
    expect(I18n.t('humbaba', {defaultValue:[':huwawa', 'Step away from the forest']})).should_be('Step away from the forest');
    expect(I18n.t('humbaba', {defaultValue:[':huwawa', ':hello']})).should_be('Hello world');
  },

  'should apply the same scope to the defaultValue as to the key itself': function(){
    expect(I18n.t('humbaba', {scope:'foo.bar', defaultValue:':baz'})).should_be('Found me');
    expect(I18n.t('humbaba', {scope:['foo', 'bar'], defaultValue:[':baf', ':baz']})).should_be('Found me');
  },

  'should pluralize when the count option is given': function(){
    expect(I18n.t('pony', {count:1})).should_be('pony');
    expect(I18n.t('pony', {count:3})).should_be('ponies');
  },

  'should interpolate values inside {{ and }} in the translation string if a value is given in the options': function(){
    expect(I18n.t('welcome', {name:'Enkidu'})).should_be('Welcome, Enkidu!');
  },

  'should interpolate {{count}} as well as pluralize it': function(){
    expect(I18n.t('forest_howto', {count:1000})).should_be('Go north 1000 leagues until you see the tall cedars');
  }

});
