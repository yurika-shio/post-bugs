$(document).on('turbolinks:load', function() {
  var preFunc = null;
  var preInput = '';
  var input = '';

  var ajaxPost = function(input) {
    $.ajax({
      url: "articles/ajax_article_list",
        type: "GET",
        data: ("q=" + input)
    });
  };
  $('#inc_search').on('keyup', function() {
    input = $.trim($(this).val());   //前後の不要な空白を削除
    if(preInput !== input){
      clearTimeout(preFunc);
      preFunc = setTimeout(ajaxPost(input), 500);
    }
    else{
      alert('文字が入力されませんでした');
    }
    preInput = input;
  });
});
