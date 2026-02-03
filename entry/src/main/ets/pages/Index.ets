import { router, SubHeaderV2Title } from '@kit.ArkUI';
import { http } from '@kit.NetworkKit';
import { RootObject } from '../bean/RootObject';

interface project{
  selected:boolean
  name:string
}
function edit(x:project){

}

@Entry
@Component
struct Index {

  @Builder myBuilder(itemIndex:number,title:string,img:string){
    Column(){
      Image($r(img))
        .width(30)
        .fillColor(this.selectedIndex==itemIndex?"#ff377cf5":Color.Grey)
      Text(title)
        .fontColor(this.selectedIndex==itemIndex?"#ff377cf5":Color.Gray)
    }
  }
  @State projects:project[]=[{ selected:false,name:"准备明天的会议材料"}]
  @State selectedIndex: number = 0;
  @State errorMSg: string = '';
  @State addItem: project = {selected:false,name:''}
  req=http.createHttp()

  build() {
     Tabs({barPosition:BarPosition.End}){
       TabContent(){
         Column(){
           Row(){
             Text("我的待办")

               .fontColor(Color.White)
               .fontSize(32)
               .width("100%")
               .layoutWeight(1)
             Image($r("app.media.ic_search"))
               .width(40)
               .margin(10)
           }
           .backgroundColor("#458Af5")
           .padding(10)
           .width("100%")

           Tabs(){
             TabContent(){

               Scroll(){
                 Column({space:10}){
                   ForEach(this.projects,(item:project,index)=>{
                     Row({space:5}){
                       Checkbox()
                         .select(item.selected)
                         .onChange(value=>{
                           this.projects[index].selected=value
                         })
                       Text(item.name)
                         .layoutWeight(1)
                       Image($r("app.media.ic_edit"))
                         .width(30)
                         .onClick(()=>{
                           edit(item)
                         })

                       Image($r("app.media.ic_delete"))
                         .width(30)
                         .onClick(()=>{
                           this.projects.pop()
                         })

                     }
                     .padding(10)
                     .border({
                       width:1
                     })
                     .borderRadius(20)
                   })
                   Row({space:5}){
                     TextInput({placeholder:"添加新的待办事项。。。"})
                       .type(InputType.USER_NAME)
                       .layoutWeight(1)
                       .onChange(value=>{
                         this.addItem.name=value
                       })
                     Image($r("app.media.ic_add"))
                       .width(30)
                       .onClick(()=>{
                         if (this.addItem.name != '') {
                           this.projects.push(this.addItem)
                           this.addItem={selected:false,name:""}
                         }
                       })
                   }.position({y:450})
                 }
                 .padding(10)
                 .width("100%")
                 .height("100%")

               }
               .width("100%")
               .height("100%")

             }
             .tabBar("全部")
             TabContent(){

               Scroll(){
                 Column({space:10}){
                   ForEach(this.projects,(item:project,index)=>{
                     if(item.selected==false){
                       Row({space:5}){
                         Checkbox()
                           .select(item.selected)
                           .onChange(value=>{
                             this.projects[index].selected=value
                           })
                         Text(item.name)
                           .layoutWeight(1)
                         Image($r("app.media.ic_edit"))
                           .width(30)
                           .onClick(()=>{
                             edit(item)
                           })

                         Image($r("app.media.ic_delete"))
                           .width(30)
                           .onClick(()=>{
                             this.projects.pop()
                           })

                       }
                       .padding(10)
                       .border({
                         width:1
                       })
                       .borderRadius(20)
                     }
                   })
                   Row({space:5}){
                     TextInput({placeholder:"添加新的待办事项。。。"})
                       .type(InputType.USER_NAME)
                       .layoutWeight(1)
                       .onChange(value=>{
                         this.addItem.name=value
                       })
                     Image($r("app.media.ic_add"))
                       .width(30)
                       .onClick(()=>{
                         if (this.addItem.name != '') {
                           this.projects.push(this.addItem)
                           this.addItem={selected:false,name:""}
                         }
                       })
                   }.position({y:450})
                 }
                 .padding(10)
                 .width("100%")
                 .height("100%")

               }
               .width("100%")
               .height("100%")

             }
             .tabBar("未完成")
             TabContent(){

               Scroll(){
                 Column({space:10}){
                   ForEach(this.projects,(item:project,index)=>{
                     if(item.selected){
                       Row({space:5}){
                         Checkbox()
                           .select(item.selected)
                           .onChange(value=>{
                             this.projects[index].selected=value
                           })
                         Text(item.name)
                           .layoutWeight(1)
                         Image($r("app.media.ic_edit"))
                           .width(30)
                           .onClick(()=>{
                             edit(item)
                           })

                         Image($r("app.media.ic_delete"))
                           .width(30)
                           .onClick(()=>{
                             this.projects.pop()
                           })

                       }
                       .padding(10)
                       .border({
                         width:1
                       })
                       .borderRadius(20)
                     }
                   })
                   Row({space:5}){
                     TextInput({placeholder:"添加新的待办事项。。。"})
                       .type(InputType.USER_NAME)
                       .layoutWeight(1)
                       .onChange(value=>{
                         this.addItem.name=value
                       })
                     Image($r("app.media.ic_add"))
                       .width(30)
                       .onClick(()=>{
                         if (this.addItem.name != '') {
                           this.projects.push(this.addItem)
                           this.addItem={selected:false,name:""}
                         }
                       })
                   }.position({y:450})
                 }
                 .padding(10)
                 .width("100%")
                 .height("100%")

               }
               .width("100%")
               .height("100%")

             }
             .tabBar("已完成")
           }
           .scrollable(false)
           .animationDuration(0)
         }
       }
       .tabBar(this.myBuilder(0,"首页",'app.media.ic_index'))
       TabContent(){
         Column() {
           Text("退出")
             .onClick(() => {
               this.req.request("https://www.wanandroid.com/user/logout/json", {
                 method: http.RequestMethod.GET,
                 header: { "content-type": "application/json" }
               }).then(res => {
                 let r: RootObject = JSON.parse(res.result + '') as RootObject
                 console.log("POST", r.errorCode)
                 if (r.errorCode == -1) {
                   this.errorMSg = r.errorMsg
                 } else {
                   router.pushUrl({
                     url: "pages/Login"
                   })
                 }
               })
             })
         }
       }
       .tabBar(this.myBuilder(1,"我的",'app.media.ic_my'))
     }
     .onChange((index:number)=>{
       this.selectedIndex=index
     })
     .scrollable(false)
     .animationDuration(0)
     .height('100%')
     .width('100%')
  }
}