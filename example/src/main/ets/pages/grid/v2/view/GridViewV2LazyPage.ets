import { TitleBar } from '@abner/bar';
import { GridView, RefreshDataSource } from '@abner/refresh_v2';
import { RouterPath } from '@abner/router';
import { ListItemV2View } from '../../../../view/ListItemV2View';

/**
 * AUTHOR:AbnerMing
 * DATE:2023/10/14
 * INTRODUCE:懒加载数据
 * */

@RouterPath("example_GridViewV2LazyPage")
@ComponentV2
export struct GridViewV2LazyPage {
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
      TitleBar({ title: "(V2)懒加载数据模式(GridView)" })
      GridView({
        lazyDataSource: this.lazyDataSource,
        itemLayout: this.itemLayout,
        lazyCachedCount: 10, //缓存数量
        gridAttribute: (attr) => {
          attr.edgeEffect = EdgeEffect.Spring //设置阻尼效果
        }
      })
    }
  }
}
