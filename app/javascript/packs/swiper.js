$(function(){
  const swiper = new Swiper('.swiper', {

   loop: true, //最後に達したら先頭に戻る
   slidesPerView: '6', //何枚表示するか
   speed: 2700, // スライドアニメーションのスピード（ミリ秒）
   centeredSlides : true,
	 autoplay: { //自動再生する
		delay: 2700, //次のスライドに切り替わるまでの時間
      disableOnInteraction: false, //ユーザーが操作したら止めるか
      waitForTransition: false, // アニメーションの間にスライドを止めるか
	},
   //ページネーション表示の設定
   pagination: {
     el: '.swiper-pagination', //ページネーション要素のクラス名
     clickable: true, //クリック可能にするか
     type: 'bullets', //ページネーションの種類
   },

   //ナビゲーションボタン（矢印）表示の設定
   navigation: {
     nextEl: '.swiper-button-next', //「次へボタン」要素のクラス名
     prevEl: '.swiper-button-prev', //「前へボタン」要素のクラス名
   },

   responsive: [
    {
      breakpoint: 500, // 500px未満で・・・
      settings: "unslick", // スライダーを無効
    },
   ],

    //オプションの設定
    // loop: true, //最後までスライドしたら最初の画像に戻る

    // //ページネーション表示の設定
    // pagination: {
    //   el: '.swiper-pagination', //ページネーションの要素
    // },

    // //ナビゲーションボタン（矢印）表示の設定
    // navigation: {
    //   nextEl: '.swiper-button-next', //「次へボタン」要素の指定
    //   prevEl: '.swiper-button-prev', //「前へボタン」要素の指定
    // }
  });
})

$(window).on("resize orientationchange", function(){
  $(".slider").slick("resize");
});