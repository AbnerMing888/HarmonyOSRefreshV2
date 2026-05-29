import { ListView, RefreshDataSource } from '@abner/refresh_v2'
import { RouterPath } from '@abner/router'
import { TitleBar } from '@abner/bar'
import { ListItemV2View } from '../../../../view/ListItemV2View'

/**
 * AUTHOR:AbnerMing
 * DATE:2023/10/14
 * INTRODUCE:懒加载数据ListView
 * */
@RouterPath("example_ListViewV2LazyPage")
@ComponentV2
export struct ListViewV2LazyPage {
  lazyDataSource?: RefreshDataSource = new RefreshDataSource()

  aboutToAppear() {
    let array: number[] = []
    for (let i = 0; i < 20; i++) {
      array.push(i)
    }
    this.lazyDataSource?.initData(array)
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
      TitleBar({ title: "(V2)懒加载数据ListView" })
      ListView({
        lazyDataSource: this.lazyDataSource,
        itemLayout: this.itemLayout, //转成你需要的对象
        listAttribute: (attr) => {
          attr.edgeEffect = EdgeEffect.Spring
        }
      })
    }
  }
}