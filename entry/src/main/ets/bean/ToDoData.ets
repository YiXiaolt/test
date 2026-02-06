export class ToDoData{
  selected:boolean;//是否完成任务
  name:string;//待办事项名称
  timeString:string ;//发布时间
  time:number//时间戳

  constructor(selected:boolean,name:string,time:number) {
    this.selected=selected
    this.name=name
    this.timeString=this.convertTime(time)
    this.time=time
  }
  convertTime(timestamp:number) :string{
    const nowTime=new Date().getTime()
    const timeDifferent=(nowTime-timestamp)/1000
    if (timeDifferent<86400 || timeDifferent==0 ) {
      return '今日';
    }else{
      return new Date(timestamp).toLocaleString();
    }
  }

  reset() {
    this.selected = false; // 初始：未完成
    this.name = ""; // 初始：空名称（可根据需求改为固定初始名，如"新待办"）
    this.time = new Date().getTime(); // 初始：当前时间戳
    this.timeString = this.convertTime(this.time); // 同步格式化时间
  }

}
export const createListRange=():ToDoData[]=>{
  let result:ToDoData[]=new Array()
  result =[
    new ToDoData( false,  "完成项目设计稿", new Date().getTime()),
    new ToDoData( false,  "准备明天的会议材料", new Date().getTime()),
    new ToDoData( false,  "购买生活用品", new Date().getTime()),
    new ToDoData( false,  "学习新的技术知识", new Date().getTime()),
    new ToDoData( false,  "回复客户邮件", new Date().getTime()),
  ]
  return result
}