// Generated by CoffeeScript 1.8.0
(function() {
  var animation;

  $('.navbar .navbar-right li').tooltip(animation = true);

$(function() {
    var $pt;
    $pt = '<div class="popover" role="tooltip"><div class="arrow"></div><h3 class="popover-title"></h3><div class="popover-content"></div><a href="#" class="btn btn-default">Activate</a></div>';
    return $('[data-toggle="popover"]').popover({
      template: $pt
    });
  });
  $(document).on('scroll', function() {
    return $('.shadow-bar').toggleClass('show-shadow', $(this).scrollTop() > 0);
  });

  $('.selectable').on("click", function() {
    $(this).toggleClass('selected');
    if ($('#pageid').val() == 1) {
       reloadtaskdata();     
    } else if ($('#pageid').val() == 2) {
        reloadVotes();
    }
    
  });

  $(function() {
    return $('.v-list').metisMenu();
  });
  jQuery("abbr.timeago").timeago();

}).call(this);


function submitPost(id) {
      //  $('.submit-response').html("Submitting post for voting...");
        var task_photo_selected = '0';
        var post_text = $('#textarea_'+id).val();
        var task_id = id;
        //console.log(task_photo_selected + ' !! ' + post_text + ' !! ' + task_id);
        if (post_text) {
            if (task_photo_selected) {
                 $.ajax({
                   type: 'POST',
                   url: '/post',
                   data: {
                       user_post : {task_id : task_id, tasks_photo_id: 1, description: post_text,
                       user_id: $('#current_user_id').html()}
                   },
                success:function(data){
                    location.reload();
                   },
                   error: function(data) { // if error occured
//                         alert("Error occured.please try again");
//                         alert(data);
location.reload();
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


function reloadtaskdata() {
    //filters :
    var reward = [];
    var qualification = [];
    var category = [];
    $('.selected').each(function() { 
        var id = this.id.split('_');
        if (id[0] === 'reward') {
            reward.push(id[1]);
        } else if (id[0] === 'qualification') {
            qualification.push(id[1]);
        } else if (id[0] === 'category') {
            category.push(id[1]);
        }
    });
    
    //ajax request to load the data
    
    $.ajax({
                   type: 'POST',
                   url: '/tasks#index',
                   data: {
                       reward : reward,
                       qualification : qualification,
                       category : category,
                       userid : $('#current_user_id').html()
                   },
                success:function(json){
                    var template = $('#card').html();
                    Mustache.parse(template);   // optional, speeds up future uses
                    //var json = JSON.parse(data);
                    var rendered = Mustache.render(template, json);
                    $('#task-cards-veche').html(rendered);
                   },
                   error: function(data) { // if error occured
//                         alert("Error occured.please try again");
//                         alert(data);
location.reload();
                    }
                  });
}

    var votePost = function(id) {
        var votes = [];
        $('.card-vote').each(function(){ 
            votes.push($(this).attr('id'));
        });
        var lostid;
        console.log(votes + ' sdf ' + lostid );
        for (var i = 0 ; i < votes.length; i ++ ) {
            console.log(votes[i] + ' sdf ' + id );
            if (votes[i] != id) {
                lostid = votes[i];
                break;
            }
        }
        console.log(votes + ' sdf ' + lostid );
        $.ajax({
                   type: 'POST',
                   url: '/votefortask',
                   data: {
                       wonid : id,
                       lostid: lostid,
                       userid : $('#current_user_id').html()
                   },
                success:function(json){
                    console.log(json);
                    location.reload();
                   // reloadVotes();
//                    if (json === 1) {
//                        
//                    }
                   },
                   error: function(data) { // if error occured
                       //  alert("Error occured.please try again");
                        // alert(data);
                        reloadVotes();
                    }
                  });
}

var reloadVotes = function() {
    //filters :
    var reward = [];
    var qualification = [];
    var category = [];
    $('.selected').each(function() { 
        var id = this.id.split('_');
        if (id[0] === 'reward') {
            reward.push(id[1]);
        } else if (id[0] === 'qualification') {
            qualification.push(id[1]);
        } else if (id[0] === 'category') {
            category.push(id[1]);
        }
    });
    
    //ajax request to load the data
   
    $.ajax({
                   type: 'POST',
                   url: '/vote',
                   data: {
                       reward : reward,
                       qualification : qualification,
                       category : category,
                       userid : $('#current_user_id').html()
                   },
                success:function(json){
                    var template = $('#card').html();
                    Mustache.parse(template);   // optional, speeds up future uses
                    //var json = JSON.parse(data);
                    var rendered = Mustache.render(template, json);
                    $('#task-cards-veche').html(rendered);
                   },
                   error: function(data) { // if error occured
                         alert("Error occured.please try again");
                         alert(data);
                    }
                  });
}

var fetchPointsWon = function() {
    
    
    
        $.ajax({
                   type: 'POST',
                   url: '/fetchPointsDetails',
                success:function(json){
                    console.log(json);
                                        var template = $('#points').html();
                    Mustache.parse(template);   // optional, speeds up future uses
                    //var json = JSON.parse(data);
                    var rendered = Mustache.render(template, json);
                    $('#points_notification_id').html(rendered);
                    jQuery("abbr.timeago").timeago();
                   },
                   error: function(data) { // if error occured
//                         alert("Error occured.please try again");
//                         alert(data);
console.log(data);
                    }
                  });
    
    

}

var purchaseperk = function(id) {
    $.ajax({
                   type: 'POST',
                   url: '/purchaseperks',
                   data : {
                       'id' : id
                   },
                success:function(json){
                    console.log(json);
                    location.reload();
                   },
                   error: function(data) { // if error occured
//                         alert("Error occured.please try again");
//                         alert(data);
console.log(data);
location.reload();
                    }
                  });
}
