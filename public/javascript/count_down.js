window.addEventListener('load', function(){
  const createDt = document.getElementById("limitdate")
  const reviewId = createDt.getAttribute("data-id")
  const days = 86400 * reviewId;
  let dt = new Date();
  let endDt = new Date(dt.getTime() + days * 1000);
  console.log( dt)
  console.log(endDt)
  console.log(reviewId)
  let cnt = days;
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