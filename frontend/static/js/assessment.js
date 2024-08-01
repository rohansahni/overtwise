var quiz_title = 'Codepen Quiz'
$('#nav-text').append(quiz_title)
var quiz = {
  'What is Cascading style sheets?': ['CSS*', 'CMS', 'CDN'],
  'What is an invalid Html Tag': ['&lt;radar>', '&lt;audio>', '&lt;address>'],
  'What is SASS': ['Prefixer', 'Preprocessor', 'Predecesor'],
}

for (const item in quiz) {
  for (const [i, v] of quiz[item].entries()) {
    quiz[item][i] = v.replace('*', '')
  }
  console.log(item)
}

var question = [
  'What is Cascading style sheets?',
  'What is an invalid Html Tag',
  'What is SASS',
]

var choices = [
  ['CSS', 'CMS', 'CDN'],
  ['&lt;radar>', '&lt;audio>', '&lt;address>'],
  ['Prefixer', 'Preprocessor', 'Predecesor'],
]
var answers = [choices[0][0], choices[1][0], choices[2][1]]
var qnum = 0
$('#nav-q').html(qnum + ' / ' + question.length)

var right = 0
var wrong = 0

$('#start').click(function () {
  $('#start-screen').css('margin-top', '-100vh')
})

function answer(x, y) {
  if (x == y) {
    return 'a'
  } else {
    return 'w'
  }
}

for (var x = 1; x <= question.length; x++) {
  $('#main').append(
    '' +
      '<div id="q' +
      x +
      '" class="screen">' +
      '<div class="question">' +
      '<div class="question-text">' +
      question[x - 1] +
      '</div>' +
      '<div class="question-answers">' +
      '<div class="button q' +
      x +
      answer(choices[x - 1][0], answers[x - 1]) +
      '">' +
      choices[x - 1][0] +
      '</div>' +
      '<div class="button q' +
      x +
      answer(choices[x - 1][1], answers[x - 1]) +
      '">' +
      choices[x - 1][1] +
      '</div>' +
      '<div class="button q' +
      x +
      answer(choices[x - 1][2], answers[x - 1]) +
      '">' +
      choices[x - 1][2] +
      '</div>' +
      '</div>' +
      '</div>' +
      '</div>'
  )
}

for (let i = 1; i <= question.length; i++) {
  $('.q' + i + 'a').click(function () {
    qnum++
    $('#nav-q').html(qnum + ' / ' + question.length)
    $('#q' + i + '').css('background', '#00E640')
    right++
    setTimeout(function () {
      $('#q' + i + '').css('margin-top', '-100vh')
    }, 500)
  })

  $('.q' + i + 'w').click(function () {
    qnum++
    $('#nav-q').html(qnum + ' / ' + question.length)
    $('#q' + i + '').css('background', 'tomato')
    wrong++
    setTimeout(function () {
      $('#q' + i + '').css('margin-top', '-100vh')
    }, 500)
  })
}

$('#q' + question.length + ' .button').click(function () {
  score(right)
})

function score(r) {
  let score = Math.round((r / question.length) * 10),
    message = 'Well done!'
  if (score <= 7) message = 'Not bad'
  if (score <= 6) message = 'Low low Keep trying'
  if (score <= 5) message = 'You suck, try again'

  $('.score-message').text(message)
  $('.score-center').text(score * 10 + '%')
}
