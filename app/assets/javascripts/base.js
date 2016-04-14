$(document).on(' ready turbolinks:load', function(){
      
    $('.repin_to_board').click(function() {

            var pin = $('.selected').attr('data-pin')
            var board = $(this).attr('data-board');

            $.ajax({

                url: "/repins",
                type: "POST",
                data: {
                    pin_id: pin,
                    board_id: board
                },
                dataType: "script",
                success: function() {
                    $('.repin_cover').fadeOut('fast')
                },
                error: function() {
                    swal({   
                         title: "Hmmmm!",   
                         text: "Looks like you are trying to save that pin multiple times to that board",   
                         type: "error",
                         timer: 2000
                    });
                }
            })
        })
      
    $('.pin_wrapper').mouseenter(function() {
        $(this).find('.cover_right').css({
            "opacity": 1,
            "transition": "opacity 50ms ease 0ms"
        });
        $(this).find('.actions').css({
            "transition": "transform 250ms cubic-bezier(0.68, -0.55, 0.265, 1.55)",
            "transform":"scale(1)"
        })
    });
    
    $('.pin_wrapper').mouseleave(function() {
        $(this).find('.cover_right').css({
            "opacity":0,
            "transition":"opacity 50ms ease 0ms"
        });
        $(this).find('.actions').css({
            "transition": "transform 250ms cubic-bezier(0.68, -0.55, 0.265, 1.55)",
            "transform":"scale(0.6)"
        })
    });
    
    $(window).bindWithDelay("scroll", function(){
        var url = $('.pagination .next_page').attr('href');
        if (url && $(window).height() > $(document).height() - $(window).scrollTop() - 250) {
            $('.la-dark').css({'display': 'block'});
            $.ajax({
                url: url,
                dataType: ('script'),
                success: function() {
                    var $grid = $('.grid').masonry({
                        itemSelector: '.grid-item',
                        percentPosition: true,
                        columnWidth: '.grid-sizer',
                        gutter: 10
                    });
                    
                    $('.la-dark').css({'display': 'none'});
                    
                    $grid.masonry('reloadItems');
                    // layout Isotope after each image loads
                    $grid.imagesLoaded().progress(function() {
                        $grid.masonry();
                    });

                    $('.pin_wrapper').mouseenter(function() {
                        $(this).find('.cover_right').css({
                            "opacity": 1,
                            "transition": "opacity 250ms ease 0ms"
                        });
                        $(this).find('.actions').css({
                            "transition": "transform 250ms cubic-bezier(0.68, -0.55, 0.265, 1.55)",
                            "transform": "scale(1)"
                        })
                    });
                    $('.pin_wrapper').mouseleave(function() {
                        $(this).find('.cover_right').css({
                            "opacity": 0,
                            "transition": "opacity 250ms ease 0ms"
                        });
                        $(this).find('.actions').css({
                            "transition": "transform 250ms cubic-bezier(0.68, -0.55, 0.265, 1.55)",
                            "transform": "scale(0.6)"
                        })
                    });
                    $('.pin_button_holder').click(function() {
                        $('.repin_cover').css({
                            "display": "block"
                        })
                    })
                    $('.pin_button_holder').click(function() {

                        $('.pin_wrapper').removeClass('selected');
                        $('.repin_image').attr('src', '');
                        $(this).closest('.pin_wrapper').addClass('selected');

                        result = $('.pin_wrapper').filter('.selected').find('.pin_holder').children().filter("img").attr('src');
                        $('.repin_image').attr('src', result.replace('frontpage_', ''));

                    });
                }
            });
        }
    }, 250);
    
    $(document).on('keyup', function(e){
    if (e.keyCode == 27){
        $('.repin_close').click();
    }
    })
    
    $('.pin_button_holder').click(function(){
        $('.repin_cover').css({"display":"block"})
    })
    
    $('.repin_close').click(function(){
        $('.repin_cover').css({"display":"none"})
    })
    // init Masonry
    var $grid = $('.grid').masonry({
      itemSelector: '.grid-item',
      percentPosition: true,
      columnWidth: '.grid-sizer',
      gutter: 10
    });
    // layout Isotope after each image loads
    $grid.imagesLoaded().progress( function() {
      $grid.masonry();
    });  
    
    $('.pin_button_holder').click(function(){
        
        $('.pin_wrapper').removeClass('selected');
        $('.repin_image').attr('src', '');
        $(this).closest('.pin_wrapper').addClass('selected');
        
        result = $('.pin_wrapper').filter('.selected').find('.pin_holder').children().filter("img").attr('src');
        $('.repin_image').attr('src', result.replace('frontpage_',''));
        
    }); 
    
    });