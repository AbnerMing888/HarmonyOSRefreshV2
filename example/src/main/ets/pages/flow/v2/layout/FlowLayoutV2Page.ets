import { TitleBar } from '@abner/bar'
import { WaterFlowLayout } from '@abner/refresh_v2'
import { RouterPath } from '@abner/router'

/**
 * AUTHOR:AbnerMing
 * DATE:2023/10/14
 * INTRODUCE:普通的列表WaterFlowLayout页面
 * */
@RouterPath("example_FlowLayoutV2Page")
@ComponentV2
export struct FlowLayoutV2Page {
  @Local array: Array<number> = []
  private itemHeightArray: number[] = []
  @Local colors: ResourceColor[] = ["#ee6d82", "#e5682f","#eeb272","#cbb41b","#d86fea","#5f97ea"]
  @Local minSize: number = 80
  @Local maxSize: number = 180

  // 计算FlowItem宽/高
  getSize() {
    let ret = Math.floor(Math.random() * this.maxSize)
    return (ret > this.minSize ? ret : this.minSize)
  }

  // 设置FlowItem的宽/高数组
  setItemSizeArray() {
    for (let i = 0; i < 50; i++) {
      this.array.push(i)
      this.itemHeightArray.push(this.getSize())
    }
  }

  aboutToAppear() {
    this.setItemSizeArray()
  }

  /**
   * Author:AbnerMing
   * Describe:条目布局
   * @param item  数据对象
   * @param index  数据索引
   */
  @Builder
  itemLayout(_: Object, index: number): void {
    Column() {
      Text("列表数据:" + index)
        .fontColor(Color.White)
    }
    .justifyContent(FlexAlign.Center)
    .width("100%")
    .height(this.itemHeightArray[index % 100])
    .backgroundColor(this.colors[index % 5])
  }

  build() {
    Column() {
      TitleBar({ title: "(V2)普通数据模式(WaterFlowLayout)" })
      WaterFlowLayout({
        items: this.array, //数据源 数组
        itemLayout: (item, index) => this.itemLayout(item, index),
        edgeEffect: EdgeEffect.Spring//开启阻尼
      })
    }
  }
}