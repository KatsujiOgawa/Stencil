window.addEventListener('load', function(){
  var sec = 86400;
  let dt = new Date();
  let endDt = new Date(dt.getTime() + sec * 1000);
  console.log( dt)
  console.log(endDt)

  let cnt = sec;
  let id = setInterval(function(){
    cnt--;
    console.log(cnt);
    // 現在日時と終了日時を比較
    dt = new Date();
    if(dt.getTime() >= endDt.getTime()){
      clearInterval(id);
      console.log("Finish!");
    }
  }, 1000);
})