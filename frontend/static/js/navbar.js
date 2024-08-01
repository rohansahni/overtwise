function test() {
  var tabsNewAnim = $('#navbarSupportedContent')
  var selectorNewAnim = $('#navbarSupportedContent').find('li').length
  var activeItemNewAnim = tabsNewAnim.find('.active')
  var activeWidthNewAnimHeight = activeItemNewAnim.innerHeight()
  var activeWidthNewAnimWidth = activeItemNewAnim.innerWidth()
  var itemPosNewAnimTop = activeItemNewAnim.position()
  var itemPosNewAnimLeft = activeItemNewAnim.position()
  $('.hori-selector').css({
    top: itemPosNewAnimTop.top + 'px',
    left: itemPosNewAnimLeft.left + 'px',
    height: activeWidthNewAnimHeight + 'px',
    width: activeWidthNewAnimWidth + 'px',
  })
  $('#navbarSupportedContent').on('click', 'li', function (e) {
    $('#navbarSupportedContent ul li').removeClass('active')
    $(this).addClass('active')
    var activeWidthNewAnimHeight = $(this).innerHeight()
    var activeWidthNewAnimWidth = $(this).innerWidth()
    var itemPosNewAnimTop = $(this).position()
    var itemPosNewAnimLeft = $(this).position()
    $('.hori-selector').css({
      top: itemPosNewAnimTop.top + 'px',
      left: itemPosNewAnimLeft.left + 'px',
      height: activeWidthNewAnimHeight + 'px',
      width: activeWidthNewAnimWidth + 'px',
    })
  })
}

$(document).ready(function () {
  setTimeout(function () {
    test()
  })
  // Add active class to the current link
  var path = window.location.pathname.split('/').pop()
  if (path == '') {
    path = 'index.html'
  }
  var target = $('#navbarSupportedContent ul li a[href="' + path + '"]')
  target.parent().addClass('active')
  test() // call test function to position the hori-selector correctly on page load
})

$(window).on('resize', function () {
  setTimeout(function () {
    test()
  }, 500)
})

$('.navbar-toggler').click(function () {
  $('.navbar-collapse').slideToggle(300)
  setTimeout(function () {
    test()
  })
})

// Add active class on another page linked
// ==========================================
// $(window).on('load',function () {
//     var current = location.pathname;
//     console.log(current);
//     $('#navbarSupportedContent ul li a').each(function(){
//         var $this = $(this);
//         // if the current path is like this link, make it active
//         if($this.attr('href').indexOf(current) !== -1){
//             $this.parent().addClass('active');
//             $this.parents('.menu-submenu').addClass('show-dropdown');
//             $this.parents('.menu-submenu').parent().addClass('active');
//         }else{
//             $this.parent().removeClass('active');
//         }
//     })
// });

//login
$(document).ready(function () {
  $('#loginForm').submit(function (event) {
    event.preventDefault()
    $.ajax({
      type: 'POST',
      url: $(this).attr('action'),
      data: $(this).serialize(),
      success: function (response) {
        if (response.success) {
          location.href = response.redirect_url
        } else {
          $('#loginForm').html(response.errors)
        }
      },
    })
  })
})

// banner code
// $(document).ready(function () {
//   // Hide the banner after 5 seconds
//   setTimeout(function () {
//     $('.banner').fadeOut('slow')
//   }, 5000)

//   // Hide the banner when any institution link is clicked
//   $('.institutions-list a').on('click', function () {
//     $('.banner').fadeOut('slow')
//   })
// })