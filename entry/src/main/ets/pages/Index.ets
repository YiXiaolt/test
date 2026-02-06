import {  ConfirmDialog, router, SubHeaderV2Title } from '@kit.ArkUI';
import { http } from '@kit.NetworkKit';
import { RootObject } from '../bean/RootObject';
import { editDialog } from '../bean/editDialog';
import { ToDoData,createListRange } from '../bean/ToDoData'
import { Constant } from "../common/Constant"

@Entry
@Component
struct Index {
  @Builder
  myBuilder(itemIndex: number, title: string, img: string) {
    Column() {
      Image($r(img))
        .width(30)
        .fillColor(this.selectedIndex == itemIndex ? "#ff377cf5" : Color.Grey)
      Text(title)
        .fontColor(this.selectedIndex == itemIndex ? "#ff377cf5" : Color.Gray)
    }
  }
  @State projects: ToDoData[] =createListRange()
  @State selectedIndex: number = 0;
  @State errorMSg: string = '';
  @State addItem: ToDoData = new ToDoData(false,"",new Date().getTime())

  req = http.createHttp()
  private dialogcontroller: CustomDialogController | null = null;

  @State userName: string = '';
  @State password: string = '';

  // 组件加载时（aboutToAppear）取值，这是核心时机！
  aboutToAppear() {
    // 按标签username拿值，断言成string类型，赋值给本地变量
    this.userName = AppStorage.Get(Constant.STORAGE_USER_NAME) as string;
    // 按标签token_pass拿值，断言成string类型，赋值给本地变量
    this.password = AppStorage.Get(Constant.STORAGE_USER_PASSWORD) as string;
  }

  build() {
    Tabs({ barPosition: BarPosition.End }) {

        TabContent() {
          Column() {
            Row() {
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

            Tabs() {
              TabContent() {

                Column({space:10}){
                  List({space:15}){
                    ForEach(this.projects, (item: ToDoData, index) => {
                      ListItem(){
                        Row({ space: 5 }) {
                          Checkbox()
                            .select(item.selected)
                            .onChange(value => {
                              item.selected = value
                              this.projects.splice(index, 1, item)
                            })
                          Column({ space: 5 }){
                            Text(item.name)
                              .fontSize(16)
                              .fontWeight(FontWeight.Medium)
                            Text(item.timeString)
                              .fontSize(12)

                          }
                          .alignItems(HorizontalAlign.Start)
                          .layoutWeight(1)

                          Image($r("app.media.ic_edit"))
                            .width(30)
                            .onClick(() => {
                              const  dialogcontroller: CustomDialogController = new CustomDialogController({
                                builder: editDialog({
                                  // 初始化输入框为当前item的name
                                  value: item.name,
                                  // 把当前遍历的item传给弹窗
                                  currentitem: item,

                                  // 回调：直接修改item的属性
                                  confirm: (newName, currentitem) => {
                                    currentitem.name = newName;
                                    currentitem.time = new Date().getTime();
                                    currentitem.timeString = currentitem.convertTime(currentitem.time);
                                    this.projects.splice(index,1,currentitem)
                                    console.log("修改后的待办：", currentitem);

                                  },
                                  onCancel: () => {
                                    dialogcontroller.close();
                                  }
                                })
                              })
                              dialogcontroller.open();
                            })

                          Image($r("app.media.ic_delete"))
                            .width(30)
                            .onClick(() => {
                              this.projects.pop()
                            })

                        }
                        .padding(10)
                        .border({
                          width: 1
                        })
                        .borderRadius(20)
                      }
                    })
                  }

                  Row({ space: 5 }) {
                    TextInput({ placeholder: "添加新的待办事项。。。" })
                      .type(InputType.USER_NAME)
                      .layoutWeight(1)
                      .onChange(value => {
                        this.addItem.name = value
                      })
                    Image($r("app.media.ic_add"))
                      .width(30)
                      .onClick(() => {
                       this.req.request(`https://www.wanandroid.com/lg/todo/add/json?title=${this.addItem.name}&content=${this.addItem.name}`,{
                         method:http.RequestMethod.POST,
                         header: {
                           "content-type": "application/json",
                           "Cookie":`loginUserName=${this.userName};loginUserPassword=${this.password}`
                         }

                       }).then(res=>{
                         console.log("network",JSON.stringify(res.result))

                       })
                      })

                  }.position({ y: 450 })
                }
                .padding(10)
                .width("100%")
                .height("100%")


              }
              .tabBar("全部")

              TabContent() {

                Column({ space: 10 }) {
                  List({space:15}){
                    ForEach(this.projects, (item: ToDoData, index) => {
                      if (item.selected == false) {
                        ListItem(){
                          Row({ space: 5 }) {
                            Checkbox()
                              .select(item.selected)
                              .onChange(value => {
                                this.projects[index].selected = value
                                this.projects.splice(index, 1, item)
                              })
                            Column({ space: 5 }){
                              Text(item.name)
                                .fontSize(16)
                                .fontWeight(FontWeight.Medium)
                              Text(item.timeString)
                                .fontSize(12)

                            }
                            .alignItems(HorizontalAlign.Start)
                            .layoutWeight(1)
                            Image($r("app.media.ic_edit"))
                              .width(30)
                              .onClick(() => {
                                const  dialogcontroller: CustomDialogController = new CustomDialogController({
                                  builder: editDialog({
                                    // 初始化输入框为当前item的name
                                    value: item.name,
                                    // 把当前遍历的item传给弹窗
                                    currentitem: item,

                                    // 回调：直接修改item的属性
                                    confirm: (newName, currentitem) => {
                                      currentitem.name = newName;
                                      currentitem.time = new Date().getTime();
                                      currentitem.timeString = currentitem.convertTime(currentitem.time);
                                      this.projects.splice(index,1,currentitem)
                                      console.log("修改后的待办：", currentitem);

                                    },
                                    onCancel: () => {
                                      dialogcontroller.close();
                                    }
                                  })
                                })
                                dialogcontroller.open();
                              })

                            Image($r("app.media.ic_delete"))
                              .width(30)
                              .onClick(() => {
                                this.projects.pop()
                              })

                          }
                          .padding(10)
                          .border({
                            width: 1
                          })
                          .borderRadius(20)
                        }
                      }
                    })
                  }
                  .layoutWeight(1)
                  Row({ space: 5 }) {
                    TextInput({ placeholder: "添加新的待办事项。。。" })
                      .type(InputType.USER_NAME)
                      .layoutWeight(1)
                      .onChange(value => {
                        this.addItem.name = value
                      })
                    Image($r("app.media.ic_add"))
                      .width(30)
                      .onClick(() => {
                        if (this.addItem.name != '') {
                          this.projects.push(this.addItem)

                        }
                      })
                  }.position({ y: 450 })
                }
                .padding(10)
                .width("100%")
                .height("100%")

              }
              .tabBar("未完成")

              TabContent() {

                Column({ space: 10 }) {
                  List({space:15}){
                    ForEach(this.projects, (item: ToDoData, index) => {
                      if (item.selected) {
                        ListItem(){
                          Row({ space: 5 }) {
                            Checkbox()
                              .select(item.selected)
                              .onChange(value => {
                                this.projects[index].selected = value
                                this.projects.splice(index, 1, item)
                              })
                            Column({ space: 5 }){
                              Text(item.name)
                                .fontSize(16)
                                .fontWeight(FontWeight.Medium)
                              Text(item.timeString)
                                .fontSize(12)

                            }
                            .alignItems(HorizontalAlign.Start)
                            .layoutWeight(1)
                            Image($r("app.media.ic_edit"))
                              .width(30)
                              .onClick(() => {
                                const  dialogcontroller: CustomDialogController = new CustomDialogController({
                                  builder: editDialog({
                                    // 初始化输入框为当前item的name
                                    value: item.name,
                                    // 把当前遍历的item传给弹窗
                                    currentitem: item,

                                    // 回调：直接修改item的属性
                                    confirm: (newName, currentitem) => {
                                      currentitem.name = newName;
                                      currentitem.time = new Date().getTime();
                                      currentitem.timeString = currentitem.convertTime(currentitem.time);
                                      this.projects.splice(index,1,currentitem)
                                      console.log("修改后的待办：", currentitem);

                                    },
                                    onCancel: () => {
                                      dialogcontroller.close();
                                    }
                                  })
                                })
                                dialogcontroller.open();
                              })

                            Image($r("app.media.ic_delete"))
                              .width(30)
                              .onClick(() => {
                                this.projects.pop()
                              })

                          }
                          .padding(10)
                          .border({
                            width: 1
                          })
                          .borderRadius(20)
                        }
                      }
                    })
                  }
                  .layoutWeight(1)
                  Row({ space: 5 }) {
                    TextInput({ placeholder: "添加新的待办事项。。。" })
                      .type(InputType.USER_NAME)
                      .layoutWeight(1)
                      .onChange(value => {
                        this.addItem.name = value
                      })
                    Image($r("app.media.ic_add"))
                      .width(30)
                      .onClick(() => {
                        if (this.addItem.name != '') {
                          this.projects.push(this.addItem)

                        }
                      })
                  }.position({ y: 450 })
                }
                .padding(10)
                .width("100%")
                .height("100%")


              }
              .tabBar("已完成")
            }
            .height("100%")
            .scrollable(false)
            .animationDuration(0)
          }
        }
        .tabBar(this.myBuilder(0, "首页", 'app.media.ic_index'))

        TabContent() {
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
        .tabBar(this.myBuilder(1, "我的", 'app.media.ic_my'))
      }

      .onChange((index: number) => {
        this.selectedIndex = index
      })
      .scrollable(false)
      .animationDuration(0)
      .height('100%')
      .width('100%')
  }
}
