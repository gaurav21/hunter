       
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
    $('.submit-response').click(function(e) {
        $(this).html("Submitting post for voting...");
    });
    
    
    $('.js-sidebar-section-leaderboard').click(function(e) {
        console.log("clicked");
        window.location.href = 'leaderboard.html';
    });
    
    
});
