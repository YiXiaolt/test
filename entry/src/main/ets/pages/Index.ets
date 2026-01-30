import { router } from '@kit.ArkUI';


@Entry
@Component
struct Index {
  @State message: string = 'Hello World';

  build() {
    Column(){
      Text("wanandroid首页")
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
      Button("退出")
        .fontSize(18)
        .onClick(()=>{
          router.pushUrl({
            url:"pages/Login"
          })
        })

    }
    .justifyContent(FlexAlign.SpaceAround)
    .height('100%')
    .width('100%')
  }
}