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
    var text = $('.quick-add__input').val();
    if (is_duplicate(text)) {
        return false;
    }
    template.show();
    template.removeAttr('disabled');
    template.find('.quick-add__item-name').text(text);
    template.find('.quick-add__hidden').val(text);
    template.find('.quick-add__hidden').attr('name', 'skill_names[]');
    $('.quick-add__list').append(template);
    $('.quick-add__item').on('click', remove_item);
};

var is_duplicate = function(input_name) {
    //TODO 追加タグが重複しないように
    return false;
};
