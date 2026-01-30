import { router } from '@kit.ArkUI';
import { http } from '@kit.NetworkKit';
import { RootObject } from '../bean/RootObject';


@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  req=http.createHttp()

  build() {
    Column(){
      Text("wanandroid首页")
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
      Button("退出")
        .fontSize(18)
        .onClick(()=>{
          this.req.request("https://www.wanandroid.com/user/logout/json",{
            method:http.RequestMethod.GET,
            header: { "Content-Type": "application/json" }
          }).then(res=>{
            let r:RootObject=JSON.parse(res.result+"") as RootObject
            console.log("network",r.errorCode);
            if(r.errorCode==0)
            {
              router.pushUrl({
                url:"pages/Login"
              })
            }
          })
        })

    }
    .justifyContent(FlexAlign.SpaceAround)
    .height('100%')
    .width('100%')
  }
}