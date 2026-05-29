import { TitleBar } from '@abner/bar'
import { ListView, RefreshController, RefreshDataSource } from '@abner/refresh_v2'
import { RouterPath } from '@abner/router'
import { ListItemV2View } from '../../../../view/ListItemV2View'

/**
 * AUTHOR:AbnerMing
 * DATE:2024/5/6
 * INTRODUCE:侧滑直接删除
 * */

@RouterPath("example_ListViewV2SlideDeletePage")
@ComponentV2
export struct ListViewV2SlideDeletePage {
  private mRefreshDataSource: RefreshDataSource = new RefreshDataSource()
  controller: RefreshController = new RefreshController() //刷新控制器

  aboutToAppear() {
    let array: Array<number> = []
    for (let i = 0; i < 20; i++) {
      array.push(i)
    }

    this.mRefreshDataSource.initData(array)
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
      TitleBar({ title: "(V2)侧滑删除" })
      ListView({
        lazyDataSource: this.mRefreshDataSource,
        isSwipeDelete: true, //滑动是否删除
        isDeleteReloadIndex: true, //删除之后是否重置索引
        controller: this.controller,
        itemLayout: (item, index) => this.itemLayout(item, index), //条目视图
        onRefresh: () => {
          this.controller.finishRefresh()
        }
      })
    }
  }
}