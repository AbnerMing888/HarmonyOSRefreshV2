import { TitleBar } from '@abner/bar';
import { GridView, RefreshController, RefreshDataSource } from '@abner/refresh_v2';
import { RouterPath } from '@abner/router';
import { ListItemV2View } from '../../../../view/ListItemV2View';

/**
 * AUTHOR:AbnerMing
 * DATE:2023/10/14
 * INTRODUCE:底部显示暂无数据
 * */

@RouterPath("example_GridViewV2NoDataPage")
@ComponentV2
export struct GridViewV2NoDataPage {
  controller: RefreshController = new RefreshController() //刷新控制器
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
      TitleBar({ title: "(V2)底部暂无数据(GridView)" })
      GridView({
        lazyDataSource: this.lazyDataSource,
        itemLayout: this.itemLayout,
        controller: this.controller,
        lazyCachedCount: 25, //缓存数量
        onRefresh: () => {
          setTimeout(() => {
            this.controller.isFooterNothing = false//改变无数据状态
            this.controller.finishRefresh()
          }, 3000)
        },
        onLoadMore: () => {
          //模拟耗时
          setTimeout(() => {
            for (let i = 0; i < 20; i++) {
              this.lazyDataSource.pushData(i)
            }
            this.controller.finishLoadMore(true)
          }, 3000)
        }
      })
    }
  }
}
