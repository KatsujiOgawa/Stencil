window.addEventListener('load', function(){
  const $tab = document.getElementById("show-tab");
  const $content = $tab.querySelectorAll('[data-content]');
  const $nav = $tab.querySelectorAll('[data-nav]');
  console.log($nav)

  // 読み込んだら最初に表示される
  $content[0].style.display = 'block';
  $nav[0].classList.add('selected-tab');


  // イベント設定
  const Click = (e) => {
    e.preventDefault();
    const $this = e.target;
    const targetValue = $this.dataset.nav;

    let index = 0;
    while(index < $nav.length){
      $content[index].style.display= 'none';
      $nav[index].classList.remove('selected-tab');
      index++;
    }
    $tab.querySelectorAll('[data-content="' + targetValue + '"]')[0].style.display = 'block'
    $nav[targetValue].classList.add('selected-tab');
  };

  // 全てのタブに適用
  let index = 0;
  while(index < $nav.length){
  $nav[index].addEventListener('click', (e) => Click(e));
  index++;
}

});
