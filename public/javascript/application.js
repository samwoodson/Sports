$(document).ready(function() {

  $('.pin').on('click', '.upvote_button', function(e) {
  // stuff to do when clicked.
  // $(".upvote_button").click(function(){
    var post_id = $(this).data("id");

    $.post("/posts/upvote/"+post_id, function( data ) {
      // console.log(data["vote_count"]);
      $('#number_votes_'+post_id).text( data['vote_count'] )
    });
    $(this)
    .removeClass('upvote_button glyphicon-thumbs-up')
    .addClass('downvote_button glyphicon-remove');

  });

   
   $('.pin').on('click', '.downvote_button', function(e) { 
    var post_id = $(this).data("id");

    $.post("/posts/downvote/"+post_id, function( data ) {
      // console.log(data["vote_count"]);
      // debugger;
      $('#number_votes_'+post_id).text( data['vote_count'] );
    });

     $(this)
  .removeClass('downvote_button glyphicon-remove')
  .addClass('upvote_button glyphicon-thumbs-up');


    // /posts/remove/<%=post.id%>
    // @.ajax({url: "/posts/upvote/ID", success: function(result){
    //   @("#div1").html(result);
    // }});

  });

});