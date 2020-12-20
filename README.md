#  UIKit Framework Note


# Start Developing iOS Apps

编码环境：Xcode12.3

## 1. 创建基础UI
1. 使用IB创建控件：1. `UITextField` 2. `UILabel`, 并使用预览功能查看不同机型，不同状态下的UI视图
2. 自动布局和`UIStackView`

## 2. 连接UI和代码
1. 将IB中视图与代码连接，并将子视图通过拖线到代码中
2. 处理用户交互：
    ```swift
    1. UIFextFieldDelegate
    2. func textFieldShouldReturn(_ textField: UITextField) -> Bool
    3. func textFieldDidEndEditing(_ textField: UITextField)
    4. resignFirstResponder() 
    ```
    当`UITextField`成为第一响应者时，键盘会自动弹出。

## 3. 使用视图控制器
1. `UIViewController`的声明周期函数
    ```swift
    viewDidLoad()
    viewWillAppear()
    viewDidAppear()
    viewWillDisappear()
    viewDidDisappear()
    ```
2. 图片视图 `UIImageView`
3. 点击手势 `UITapGestureRecognizer`
4. 相册选择器 `UIImagePickerController`，并在 `Info.plist`添加权限申请

## 4. 实现自定义控制器
1. 继承`UIStackView`实现自定义交互控件
    ```swift
    1. 重写 init 函数
    2. 添加子视图 addArrangeSubview(_:)
    3. UIButton Target-Action
    4. @IBDesignable、@IBInspectable 在IB中可视化
    5. 使用属性观察器 didSet 监听变化：1. 移除原有元素并重新创建添加
    6. UIImage(named:,in:,compatibleWidth:self.traitCollection)
    7. 设置控件不同状态的显示 // UIButton的5种状态：normal、hightlighted、focused、selected、disabled
        let bundle = Bundle(for: type(of: self))
        button.setImage(_:,for: .normal)
        button.setImage(_:,for: .selected)
        button.setImage(_:,for: .hightlighted)
        button.setImage(_:,for: [.selected,.hightlighted])
    8. 处理按钮事件
        8.1 点击按钮->获取index, 并设置属性，监听该属性->遍历子视图更新UI
    ```
2. 设置`Accessibility`, 使用`VoiceOver`提示
      ```swift
      labels、values、hints
      button.accessibilityLabel = "点击了第\(i)星"
      
      更新按钮状态后设置
      button.accessibilityHint = hintString // 再次点击将等级归零
      button.accessibilityValue = valueString // 设置了\(i)星
      ```

## 5. 定义数据模式
1. 定义数据模型，可失败构造函数
    ```swift
    init?(name: String, photo: UIImage?, rating: Int)
    ```
2. 单元测试
    ```swift
    1. @testable import <target>
    2. 测试成功用例 
        XCTAssertNotNil()
    3. 测试失败用例
        XCTAssertNil()
    ```

---

## 6. 创建列表视图
1. `UITableViewController`
    ```swift
    1. delegate
    2. dataSource
    ```
2. `UITableViewCell`

## 实现页面导航
1. `UINavigationController`
    ```swift
    1. Segue
    ```
2. 保存数据
    ```swift
    prepare(segue:,sender:)
    ```
3. `import os.long` 统一日志系统
    ```swift
    os_log("",log:,type:)
    ```
4. `Unwind Segue`
    ```swift
    创建 unwindToXXX(sender:) 函数，接受返回的数据
    新增数据
    1. 修改数据源
    2. 插入列表 tableView.insertRows(at:,with:)
    3. 在IB中将Action拖线至Exit进行关联
    更新数据
    1. tableView.indexPathForSelectedRow 确认之前选择的cell
    2. 更新数据源
    3. tableView.reloadRows(at:,with:)
    ```
5. 文本框无内容时，禁用保存按钮

## 7. 实现编辑和删除功能
1. `Segue Identifier`
    ```swift
    创建 prepareForSegue(segue:,sender:) 函数，根据Segue标识，并进行正向传递数据
    1. 确认目标VC -> 通过sender确定Cell，进一步确定数据源 -> 赋值
    ```
2. 取消编辑（`dismiss | pop`）
    ```swift
    在取消函数中，通过 presentingViewController属性确认是present还是push
    ```
    
3. 删除
    ```swift
    1. navigationItem.leftBarButtonItem = editButtonItem
    2. func tableView(_ tableView:, commit editingStyle:, forRowAt:)
        editingStyle: .delete, .insert...
        修改数据源，更新列表
    ```
## 8. 持久化数据
1. `NSObject、NSSecureCoding` 实现 
    ```swift
    encode(with aCoder:) 
    init?(coder aDecoder:)
    
    保存至文件
    FileManager().urls(for:,in:)
    
    归档
    NSKeyedArchiver.archivedData(withRootObject:, requiringSecureCoding:)
    解挡
    NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(_:)
    ```

