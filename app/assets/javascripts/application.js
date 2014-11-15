//= require jquery
//= require jquery_ujs       
$(document).ready(function() {
    //Stop carousel to cycle images automatically
    $(function() {
    $('.carousel').each(function(){
        $(this).carousel({
            interval: false
        });
    });
});
    //Opens enlarged image from the carousel
    $('.carousel-inner .item img').click(function(e) {
        $('#task-images-modal').modal('show');
    });
    
    
    //Submit button transition
//    $('.submit-response').click(function(event) {
//        event.preventDefault();
//        alert('sdfsf');
//        $(this).html("Submitting post for voting...");
//        var task_photo_selected = $('.carousel-inner').find('div.active').first().find('img').attr('id');
//        var post_text = $('#post_text').val();
//        var task_id = $('#post_id').val();
//        console.log(task_photo_selected + ' !! ' + post_text + ' !! ' + task_id);
//    });
    
    
    $('.js-sidebar-section-leaderboard').click(function(e) {
        console.log("clicked");
        window.location.href = 'leaderboard.html';
    });
    
    
});


function submitPost() {
        $('.submit-response').html("Submitting post for voting...");
        var task_photo_selected = $('.carousel-inner').find('div.active').first().find('img').attr('id');
        var post_text = $('#post_text').val();
        var task_id = $('#post_id').val();
        console.log(task_photo_selected + ' !! ' + post_text + ' !! ' + task_id);
        if (post_text) {
            if (task_photo_selected) {
                 $.ajax({
                   type: 'POST',
                   url: '/post',
                   data: {
                       user_post : {task_id : task_id, tasks_photo_id: task_photo_selected, description: post_text,
                       user_id: $('#current_user_id').html()}
                   },
                success:function(data){
                    $('.submit-response').html("Done");
                   },
                   error: function(data) { // if error occured
                         alert("Error occured.please try again");
                         alert(data);
                    }
                  });
            } else {
                $('.submit-response').html("Done");
                alert('Please select an image');
            }
        } else {
            $('.submit-response').html("Done");
            alert('Please write a post!!');
        }
}

