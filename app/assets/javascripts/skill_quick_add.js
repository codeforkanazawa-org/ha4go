var hankana2zenkana = function (str) {
  var kanaMap = {
    'ｶﾞ': 'ガ', 'ｷﾞ': 'ギ', 'ｸﾞ': 'グ', 'ｹﾞ': 'ゲ', 'ｺﾞ': 'ゴ',
    'ｻﾞ': 'ザ', 'ｼﾞ': 'ジ', 'ｽﾞ': 'ズ', 'ｾﾞ': 'ゼ', 'ｿﾞ': 'ゾ',
    'ﾀﾞ': 'ダ', 'ﾁﾞ': 'ヂ', 'ﾂﾞ': 'ヅ', 'ﾃﾞ': 'デ', 'ﾄﾞ': 'ド',
    'ﾊﾞ': 'バ', 'ﾋﾞ': 'ビ', 'ﾌﾞ': 'ブ', 'ﾍﾞ': 'ベ', 'ﾎﾞ': 'ボ',
    'ﾊﾟ': 'パ', 'ﾋﾟ': 'ピ', 'ﾌﾟ': 'プ', 'ﾍﾟ': 'ペ', 'ﾎﾟ': 'ポ',
    'ｳﾞ': 'ヴ', 'ﾜﾞ': 'ヷ', 'ｦﾞ': 'ヺ',
    'ｱ': 'ア', 'ｲ': 'イ', 'ｳ': 'ウ', 'ｴ': 'エ', 'ｵ': 'オ',
    'ｶ': 'カ', 'ｷ': 'キ', 'ｸ': 'ク', 'ｹ': 'ケ', 'ｺ': 'コ',
    'ｻ': 'サ', 'ｼ': 'シ', 'ｽ': 'ス', 'ｾ': 'セ', 'ｿ': 'ソ',
    'ﾀ': 'タ', 'ﾁ': 'チ', 'ﾂ': 'ツ', 'ﾃ': 'テ', 'ﾄ': 'ト',
    'ﾅ': 'ナ', 'ﾆ': 'ニ', 'ﾇ': 'ヌ', 'ﾈ': 'ネ', 'ﾉ': 'ノ',
    'ﾊ': 'ハ', 'ﾋ': 'ヒ', 'ﾌ': 'フ', 'ﾍ': 'ヘ', 'ﾎ': 'ホ',
    'ﾏ': 'マ', 'ﾐ': 'ミ', 'ﾑ': 'ム', 'ﾒ': 'メ', 'ﾓ': 'モ',
    'ﾔ': 'ヤ', 'ﾕ': 'ユ', 'ﾖ': 'ヨ',
    'ﾗ': 'ラ', 'ﾘ': 'リ', 'ﾙ': 'ル', 'ﾚ': 'レ', 'ﾛ': 'ロ',
    'ﾜ': 'ワ', 'ｦ': 'ヲ', 'ﾝ': 'ン',
    'ｧ': 'ァ', 'ｨ': 'ィ', 'ｩ': 'ゥ', 'ｪ': 'ェ', 'ｫ': 'ォ',
    'ｯ': 'ッ', 'ｬ': 'ャ', 'ｭ': 'ュ', 'ｮ': 'ョ',
    '｡': '。', '､': '、', 'ｰ': 'ー', '｢': '「', '｣': '」', '･': '・'
  };

  var reg = new RegExp('(' + Object.keys(kanaMap).join('|') + ')', 'g');
  return str
    .replace(reg, function (match) {
      return kanaMap[match];
    })
    .replace(/ﾞ/g, '゛')
    .replace(/ﾟ/g, '゜');
};

/**
 * 全角から半角に置き換え
 *
 * 全角チルダ、全角波ダッシュ共に半角チルダに変換
 * 全角ハイフン、全角ダッシュ、全角マイナス記号は半角ハイフンに変換
 * 長音符は半角ハイフンに含めない（住所の地名等に使用される為）
 *
 * 今は良いがUnicode 8.0で波ダッシュの形が変わるみたいなので、波ダッシュを変換に
 * 含めるべきかどうかは検討が必要
 *
 * @param {String} str 変換したい文字列
 * @param {Boolean} tilde チルダ falseを指定した場合は変換なし
 * @param {Boolean} mark 記号 falseを指定した場合は変換なし
 * @param {Boolean} hankana 半角カナ記号 trueを指定した場合のみ変換
 * @param {Boolean} space スペース falseを指定した場合は変換なし
 * @param {Boolean} alpha 英字 falseを指定した場合は変換なし
 * @param {Boolean} num 数字 falseを指定した場合は変換なし
 */
var zen2han = function (str, tilde, mark, hankana, space, alpha, num) {
  if (alpha !== false) {
    str = str.replace(/[Ａ-Ｚａ-ｚ]/g, function (s) {
      return String.fromCharCode(s.charCodeAt(0) - 65248);
    });
  }
  if (num !== false) {
    str = str.replace(/[０-９]/g, function (s) {
      return String.fromCharCode(s.charCodeAt(0) - 65248);
    });
  }
  if (mark !== false) {
    var reg = /[！＂＃＄％＆＇（）＊＋，－．／：；＜＝＞？＠［＼］＾＿｀｛｜｝]/g;
    str = str.replace(reg, function (s) {
      return String.fromCharCode(s.charCodeAt(0) - 65248);
    }).replace(/[‐－―]/g, '-');
  }
  if (tilde !== false) {
    str = str.replace(/[～〜]/g, '~');
  }
  if (space !== false) {
    str = str.replace(/　/g, ' ');
  }
  if (hankana === true) {
    var map = {'。': '｡', '、': '､', '「': '｢', '」': '｣', '・': '･'};
    var reg = new RegExp('(' + Object.keys(map).join('|') + ')', 'g');
    str = str.replace(reg, function (match) {
      return map[match];
    });
  }
  return str;
};

$(function(){
  $('.quick-add__item').on('click', remove_item);
  $('.quick-add__btn').on('click', add_item);
});

var remove_item = function() {
  $(this).attr('disabled', 'disabled');
  $(this).find('.quick-add__hidden').remove();
};

var add_item = function() {
  var template = $(this).parents('.quick-add').find('.quick-add__item--template').last().clone();
  var text = $('.quick-add__input').val().trim();
  if (text == '' || is_duplicate(text)) {
    return false;
  }
  template.show();
  template.removeAttr('disabled');
  template.find('.quick-add__item-name').text(text);
  template.find('.quick-add__hidden').val(text);
  template.find('.quick-add__hidden').attr('name', 'skill_names[]');
  $('.quick-add__list').append(template);
  $('.quick-add__item').on('click', remove_item);
  return true;
};

var current_items = function(normalizer) {
  var list = $('input.quick-add__hidden');
  var items = [];
  for( var i = 0; i < list.length; i++) {
    items.push(normalizer(list[i].defaultValue));
  }
  return items;
};

var normalized_string = function(t) {
  return hankana2zenkana(
    zen2han(
      t.toUpperCase(),
      true,
      true,
      true,
      true,
      true,
      true));
};

var is_duplicate = function(input_name) {
  return find_normalized_value(input_name) > 0;
};

var find_normalized_value = function(input_name) {
  return current_items(normalized_string).indexOf(normalized_string(input_name));
};
