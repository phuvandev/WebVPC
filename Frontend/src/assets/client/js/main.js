(function($) {
    "use strict";
    
    /*---
       stickey menu
    ---*/
    $(window).on('scroll',function() {    
           var scroll = $(window).scrollTop();
           if (scroll < 100) {
            $(".sticky-header").removeClass("sticky");
           }else{
            $(".sticky-header").addClass("sticky");
           }
    });
    
    
    /*--------------------------
     ScrollUp
    ---------------------------- */
    $.scrollUp({
        scrollText: '<i class="fa fa-angle-double-up"></i>',
        easingType: 'linear',
        scrollSpeed: 900,
        animation: 'fade'
    });
    

    /*-----
    jQuery MeanMenu
    ------------------------------ */
    $('.mobile-menu nav').meanmenu({
        meanScreenWidth: "9901",
        meanMenuContainer: ".mobile-menu",
        onePage: true,
    });
    

    /*wow activation*/
    new WOW().init();
    
    /*------addClass/removeClass -------*/
    $(".currency > a,.language > a,.top_links > a").on("click", function() {
        $(this).removeAttr('href');
        $(this).toggleClass('open').next('.dropdown_currency,.dropdown_language,.dropdown_links').toggleClass('open');
        $(this).parents().siblings().find('.dropdown_currency,.dropdown_language,.dropdown_links').removeClass('open');
    });

    $('body').on('click', function (e) {
        var target = e.target;
        if (!$(target).is('.currency > a,.language > a,.top_links > a') ) {
            $('.dropdown_currency,.dropdown_language,.dropdown_links').removeClass('open');
        }
    });
    
    /*mini cart slideToggle*/
    
    $(".cart_link > a").on("click", function() {
        $('.mini_cart').slideToggle('medium');
    }); 
    
    /*categories slideToggle*/
    $(".categories_title").on("click", function() {
        $(this).toggleClass('active');
        $('.categories_menu_inner').slideToggle('medium');
    }); 
    
     
    /*------addClass/removeClass categories-------*/
   $(".categories_menu_inner > ul > li > a, #cat_toggle.has-sub > a").on("click", function() {
        $(this).toggleClass('open').next('.categories_mega_menu,.categorie_sub').toggleClass('open');
        $(this).parents().siblings().find('.categories_mega_menu,#cat_toggle.has-sub > a').removeClass('open');
    });

    $('body').on('click', function (e) {
        var target = e.target;
        if (!$(target).is('.categories_menu_inner > ul > li > a') ) {
            $('.categories_mega_menu').removeClass('open');
        }
    });

    /*----------------------------
    slider-range here
    ------------------------------ */
    // $( "#slider-range" ).slider({
    //   range: true,
    //   min: 0,
    //   max: 500,
    //   values: [ 0, 500 ],
    //   slide: function( event, ui ) {
    //     $( "#amount" ).val( "$" + ui.values[ 0 ] + " - $" + ui.values[ 1 ] );
    //   }
    // });
    // $( "#amount" ).val( "$" + $( "#slider-range" ).slider( "values", 0 ) +
    //   " - $" + $( "#slider-range" ).slider( "values", 1 ) );
    

})(jQuery);