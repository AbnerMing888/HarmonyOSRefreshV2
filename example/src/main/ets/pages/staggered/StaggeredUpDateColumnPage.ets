import { ActionBar } from '../ActionBar'
import { RefreshController, RefreshDataSource, StaggeredGridView } from '@abner/refresh_v2'

/**
 * AUTHOR:AbnerMing
 * DATE:2025/9/24
 * INTRODUCE:瀑布流动态更新列数
 *有两种方式，一种是通过columnSize，另一种是通过columnsTemplate
 * */

@Entry
@ComponentV2
struct StaggeredUpDateColumnPage {
  @Local lazyDataSource: RefreshDataSource = new RefreshDataSource()
  refreshController: RefreshController = new RefreshController()
  @Local columnSize: number = 2
  @Local columnsTemplate: string = "1fr 1fr"

  aboutToAppear() {
    let array: Array<number> = []
    for (let i = 0; i < 50; i++) {
      array.push(i)
    }
    this.lazyDataSource.initData(array)
  }

  /**
   * Author:AbnerMing
   * Describe:条目布局
   * @param item  数据对象
   * @param index  数据索引
   */
  @Builder
  itemLayout(item: number, _: number): void {
    Text("测试数据" + item)
      .width("95%")
      .height(50)
      .height(80)
      .margin({ left: "2.5%", top: 10 })
      .textAlign(TextAlign.Center)
      .border({ width: 1, color: Color.Pink })
  }

  build() {
    Column() {
      ActionBar({ title: "动态更新列数" })
      Row() {
        Button("方式一")
          .onClick(() => {
            this.columnSize = 3
          })
        Button("方式二")
          .onClick(() => {
            this.columnsTemplate = "1fr 1fr 1fr 1fr"
          })
      }

      StaggeredGridView({
        lazyDataSource: this.lazyDataSource,
        columnSize: this.columnSize,
        columnsTemplate: this.columnsTemplate,
        itemLayout: (item: Object, index: number) => {
          this.itemLayout(item as number, index) //转成你需要的对象
        },
        lazyCachedCount: 8, //缓存数量
        controller: this.refreshController, //控制器，负责关闭下拉和上拉
        onRefresh: () => {
          //下拉刷新 模拟耗时
          setTimeout(() => {
            //模拟耗时
            this.refreshController.finishRefresh()
          }, 3000)
        },
        onLoadMore: () => {
          //上拉加载 模拟耗时
          setTimeout(() => {
            //模拟耗时
            this.refreshController.finishLoadMore()
          }, 3000)
        }
      })
    }.width("100%")
    .height("100%")
  }
}