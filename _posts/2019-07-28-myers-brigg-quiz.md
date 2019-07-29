---
layout: post
title:  "Can you match a celebrity to their Myers-Brigg?"
date:   2019-07-28 01:45:29 -0500
categories: quiz
---

<h2 class='celebrity-name'></h2>

<img class='celebrity-image' />
<div class="quiz">
  
  <h2 class="quiz-question">First letter</h2>
  <ul data-quiz-question="1">
    <li class="quiz-answer" data-quiz-answer="E">Extraverted (E)</li>
    <li class="quiz-answer" data-quiz-answer="I">Introverted (I)</li>
  </ul>
  
  <h2 class="quiz-question">Second Letter</h2>
  <ul data-quiz-question="2">
    <li class="quiz-answer" data-quiz-answer="S">Sensing (S)</li>
    <li class="quiz-answer" data-quiz-answer="N">Intuitive (N)</li>
  </ul>
  
  <h2 class="quiz-question">Third Letter</h2>
  <ul data-quiz-question="3">
    <li class="quiz-answer" data-quiz-answer="T">Thinking (T)</li>
    <li class="quiz-answer" data-quiz-answer="F">Feeling (F)</li>
  </ul>
  
  <h2 class="quiz-question">Fourth Letter</h2>
  <ul data-quiz-question="4">
    <li class="quiz-answer" data-quiz-answer="J">Judging (J)</li>
    <li class="quiz-answer" data-quiz-answer="P">Perceiving (P)</li>
  </ul>
</div>

<div class="quiz-result"></div>

**Refresh the page to try again!**

*Most of this work was borrowed.* Thank you to [this Codepen](https://codepen.io/tgallimore/pen/xwGOXB) for the code template, and to [this article](https://www.fromthegrapevine.com/arts/which-celebritys-personality-do-you-have) for the content.

A disclaimer: I don't have 100% confidence in these answers since there's no citation from the site. The authors could have just mapped *likely* personality types to each celebrity based on that celebrity's public image. If there ever is a site with more accurate sources, I'd be happy to switch the underlying form answers!

<style>
body {
  margin:0;
  padding:20px;
}
.celebrity-image {
    max-width: 60%;
    margin: 0 auto;
}
.quiz {
  padding:0 30px 20px 30px;
  max-width:960px;
  margin:0 auto;
}

.quiz ul {
  list-style:none;
  padding:0;
  margin:0;
}

.quiz-question {
  font-weight:bold;
  display:block;
  padding:30px 0 10px 0;
  margin:0;
}
.quiz-answer {
  margin:0;
  padding:10px;
  background:#f7f7f7;
  margin-bottom:5px;
  cursor: pointer;
}

.quiz-answer.hover {
  background:#eee;
}
  
.quiz-answer::before {
  content:"";
  display:inline-block;
  width:15px;
  height:15px;
  border:1px solid #ccc;
  background:#fff;
  vertical-align:middle;
  margin-right:10px;
}
  
.quiz-answer.active::before {
  background-color:#333;
  border-color:#333;
}

.quiz-answer.correct::before {
  background-color:green;
  border-color:green;
}

.quiz-answer.incorrect::before {
  background-color:red;
  border-color:red;
}

.quiz-answer.correct::before {
  outline: 2px solid green;
  outline-offset: 2px;    
}

.quiz-result {
  max-width:960px;
  margin:0 auto;
  font-weight:bold;
  text-align:center;
  color: #fff;
  padding:20px;
}

.good {
  background: green;
}
.mid {
  background: orange;
}
.bad {
  background: red;
}
</style>

<script
  src="https://code.jquery.com/jquery-3.4.1.js"
  integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
  crossorigin="anonymous"></script>

<script type="text/javascript">
var Quiz = function(){
  var self = this;
  this.init = function(){
    self._bindEvents();
    self._pickACelebrity();
  }

  this.celebrities = [
    {
        name: 'Barack Obama', answer: 'ENFJ',
        image: 'https://www.washingtonpost.com/resizer/pec7u2iaAmRp_cPEfOPNLE1qqAM=/1484x0/arc-anglerfish-washpost-prod-washpost.s3.amazonaws.com/public/MENB4PFP5EI6TIGJNUWXQGHT3I.jpg'
    },
    {
        name: 'Albert Einstein', answer: 'INTP',
        image: 'https://i2.wp.com/www.brainpickings.org/wp-content/uploads/2013/10/einsteinlaughing.jpg?w=680&ssl=1'
    },
    {
        name: 'Weird Al Yankovic', answer: 'ENTP',
        image: 'https://miro.medium.com/max/1024/1*wQ3AHAzzYrGVAidLxrcO_w.jpeg'
    },
    {
        name: 'Natalie Portman', answer: 'ESTJ',
        image: 'https://www.indiewire.com/wp-content/uploads/2018/04/shutterstock_9376223ao.jpg?w=780'
    },
    {
        name: 'Matt Damon', answer: 'ISTJ',
        image: 'https://pmcvariety.files.wordpress.com/2018/01/matt-damon-metoo.jpg?w=1000'
    },
    {
        name: 'Mother Teresa', answer: 'ISFJ',
        image: 'https://media.fromthegrapevine.com/assets/images/2016/3/teresa-small.jpg.824x0_q71.jpg'
    },
    {
        name: 'Michael J Fox', answer: 'ESTP',
        image: 'https://www.telegraph.co.uk/content/dam/film/backtothefuture/backtofuture4-xlarge.jpg'
    },
    {
        name: 'Marilyn Monroe', answer: 'ESFP',
        image: 'https://s.abcnews.com/images/GMA/marilyn-monroe-gty-jc-190131_hpMain_16x9_992.jpg'
    },
    {
        name: 'Bruce Lee', answer: 'ISTP',
        image: 'https://www.star2.com/wp-content/uploads/2018/07/str2_dabrucelee_MAIN_cn-e1532050151469-1170x480.jpg'
    },
    {
        name: 'John Travolta', answer: 'ISFP',
        image: 'https://media.fromthegrapevine.com/assets/images/2015/11/danny.jpg.824x0_q71.jpg'
    },
    {
        name: 'Jane Austen', answer: 'INTJ',
        image: 'https://www.biography.com/.image/t_share/MTM1MTY0MzU4OTI0NzM1NzYy/jane-austen_in_blue_dress_e5nojpg.jpg'
    },
    {
        name: 'Dr. Seuss', answer: 'ENFP',
        image: 'https://www.beaninspirer.com/wp-content/uploads/2019/03/Dr-Seuss-The-American-Childrens-Author-and-Cartoonist.jpg'
    },
    {
        name: 'Shirley Temple Black', answer: 'INFJ',
        image: 'https://media.fromthegrapevine.com/assets/images/2016/3/shirley-temple-0323-new.jpg.824x0_q71.jpg'
    },
    {
        name: 'J. R. R. Tolkien', answer: 'INFP',
        image: 'https://pmcvariety.files.wordpress.com/2017/07/j-rr-tolkein.jpg?w=1000'
    },
    {
        name: 'George Washington', answer: 'ISTJ',
        image: 'https://www.history.com/.image/t_share/MTYxNzYzNzIzODIyNzY5NDU0/first-10-presidents-washington-promo.jpg'
    },
    {
        name: 'Michael Jordan', answer: 'ISTP',
        image: 'https://statics.sportskeeda.com/editor/2018/03/a4a7b-1520474015-800.jpg'
    },
    {
        name: 'Steven Spielberg', answer: 'ISFP',
        image: 'https://pmcvariety.files.wordpress.com/2017/04/steven-spielberg.jpg?w=1000'
    },
    {
        name: 'Steve Jobs', answer: 'ENTJ',
        image: 'https://cdn.vox-cdn.com/thumbor/WqMY2QINJvS9H0tqdrFBXsg2ghk=/0x86:706x557/1200x800/filters:focal(0x86:706x557)/cdn.vox-cdn.com/imported_assets/847184/stevejobs.png'
    },
    {
        name: 'Walt Disney', answer: 'ENTP',
        image: 'https://www.laughingplace.com/w/wp-content/uploads/2015/12/Walt-Disney-0111.jpg'
    }

  ];

  this._pickAnswer = function($answer, $answers){
    $answers.find('.quiz-answer').removeClass('active');
    $answer.addClass('active');
  }
  this._pickACelebrity = function() {
    var nCelebrities = this.celebrities.length;  
    var random = Math.floor(Math.random() * nCelebrities);
    self.celebrity = this.celebrities[random];
    $('.celebrity-name').html(self.celebrity.name);
    // $('.celebrity-image').attr('href', self.celebrity.image);
    $('.celebrity-image').attr('src', self.celebrity.image);
  }
  this._calcResult = function(){
    var numberOfCorrectAnswers = 0;
    var fullAnswer = this.celebrity.answer;
    var currentLetter = 0;
    $('ul[data-quiz-question]').each(function(i){
      var $this = $(this),
          chosenAnswer = $this.find('.quiz-answer.active').data('quiz-answer'),
          correctAnswer = fullAnswer[currentLetter];

      if ( chosenAnswer == correctAnswer ) {
        numberOfCorrectAnswers++;

        // highlight this as correct answer
        $this.find('.quiz-answer.active').addClass('correct');
      }
      else {
        $this.find('.quiz-answer[data-quiz-answer="'+correctAnswer+'"]').addClass('correct');
        $this.find('.quiz-answer.active').addClass('incorrect');
      }
      currentLetter++;
    });
    if ( numberOfCorrectAnswers < 2 ) {
      return {code: 'bad', text: 'Pretty wrong'};
    }
    else if ( numberOfCorrectAnswers < 4 ) {
      return {code: 'mid', text: 'So close...'};
    }
    else {
      return {code: 'good', text: 'Perfect!'};
    }
  }
  this._isComplete = function(){
    var answersComplete = 0;
    $('ul[data-quiz-question]').each(function(){
      if ( $(this).find('.quiz-answer.active').length ) {
        answersComplete++;
      }
    });
    return answersComplete > 3;
  }
  this._showResult = function(result){
    $('.quiz-result').addClass(result.code).html(result.text);
  }
  this._bindEvents = function(){
    $('.quiz-answer').on('click', function(){
      var $this = $(this),
          $answers = $this.closest('ul[data-quiz-question]');
      self._pickAnswer($this, $answers);
      if ( self._isComplete() ) {

        // scroll to answer section
        $('html, body').animate({
          scrollTop: $('.quiz-result').offset().top
        });

        self._showResult( self._calcResult() );
        $('.quiz-answer').off('click');
      }
    });
  }
}

var quiz = new Quiz();
quiz.init();
</script>