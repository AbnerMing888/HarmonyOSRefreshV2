import { TitleBar } from "@abner/bar";
import { ListLayout } from "@abner/refresh_v2";
import { RouterPath } from "@abner/router"
import { ListItemV2View } from "../../../../view/ListItemV2View";

/**
 * AUTHOR:AbnerMing
 * DATE:2026/4/22
 * INTRODUCE:普通的列表ListLayout
 * */

@RouterPath("example_ListLayoutV2Page")
@ComponentV2
export struct ListLayoutV2Page {
  @Local array: number[] = []

  aboutToAppear() {
    for (let i = 0; i < 20; i++) {
      this.array.push(i)
    }
  }

  /**
   * Author:AbnerMing
   * Describe:条目布局
   * @param item  数据对象
   * @param index  数据索引
   */
  @Builder
  itemLayout(_: Object, index: number): void {
    ListItemV2View({ index: index })
  }

  build() {
    Column() {
      TitleBar({ title: "(V2)普通的列表ListLayout" })
      ListLayout({
        items: this.array,
        itemLayout: this.itemLayout,
        listAttribute: (attr) => {
          attr.edgeEffect = EdgeEffect.Spring //开启弹性滚动效果
        }
      })
    }.width("100%")
    .height("100%")
  }
}