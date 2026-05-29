import { TitleBar } from '@abner/bar';
import { GridView, RefreshDataSource } from '@abner/refresh_v2';
import { RouterPath } from '@abner/router';
import { ListItemV2View } from '../../../../view/ListItemV2View';

/**
 * AUTHOR:AbnerMing
 * DATE:2023/10/14
 * INTRODUCE:自适应高度，顶部
 * */

@RouterPath("example_GridViewV2AdaptiveBottomPage")
@ComponentV2
export struct GridViewV2AdaptiveBottomPage {
  lazyDataSource: RefreshDataSource = new RefreshDataSource()

  aboutToAppear() {
    let array: Array<number> = []
    for (let i = 0; i < 50; i++) {
      array.push(i)
    }
    this.lazyDataSource.pushDataArray(array)
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
      TitleBar({ title: "(V2)自适应高度底部(GridView)" })
      GridView({
        lazyDataSource: this.lazyDataSource,
        itemLayout: this.itemLayout,
        lazyCachedCount: 10, //缓存
        gridAttribute: (attr) => {
          attr.edgeEffect = EdgeEffect.Spring //设置阻尼效果
        }
      })
      Text("我是底部的视图")
        .width("100%")
        .height(100)
        .fontColor(Color.White)
        .textAlign(TextAlign.Center)
        .backgroundColor($r("app.color.tab_select_color"))
    }
  }
}
