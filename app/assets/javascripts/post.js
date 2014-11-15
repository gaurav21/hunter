 $(document).ready(function(){
      $('.submit-response').click(function(event) {
        event.preventDefault();
        alert('sdfsf');
        $(this).html("Submitting post for voting...");
        var task_photo_selected = $('.carousel-inner').find('div.active').first().find('img').attr('id');
        var post_text = $('#post_text').val();
        var task_id = $('#post_id').val();
        console.log(task_photo_selected + ' !! ' + post_text + ' !! ' + task_id);
    });
 }) ;