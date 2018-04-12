//
//  main.swift
//  EyreFree
//
//  Created by EyreFree on 2017/9/13.
//
//  Copyright (c) 2017 EyreFree <eyrefree@eyrefree.org>
//
//  This file is part of EFResume.
//
//  EFResume is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  EFResume is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with this program.  If not, see <http://www.gnu.org/licenses/>.

import Foundation

func main() {
    // 打开模板文件
    var templete = EFTemplete(path: EFPath.templete)

    // 填入内容
    input(templete: &templete)

    // 打开生成的简历文件
    let resume = EFFile(path: EFPath.resume)
    // 应用所填入的信息
    resume.content = templete.apply()
    // 保存
    resume.save()
}

func input(templete: inout EFTemplete) {
    // 资源路径
    templete.basePath.set("https://eyrefree.github.io/EFResume")

    // 页面属性
    templete.pageTitle.set("龚巨军+iOS  的个人简历")
    templete.pageDescription.set("龚巨军+iOS 的个人简历")

    // 基本信息
    templete.name.set("龚巨军")
    templete.description.set(" iOS 开发")
    templete.basicInfo.set(
        [
            "基本信息": [
                "性别：男",
                "现居地：广州",
//                "微信：sg6548676",
//                "手机：17620021014",
//                "邮箱：sg6548676@gmail.com"
            ],
            "联系方式": [
                "手机：17620021014",
                "邮箱：sg6548676@gmail.com"
            ]
        ]
    )
    
    // 个人经验
    templete.experience.set(
        [
            
            "2": [
                "M 年 iOS 开发经验；",
                //                "了解移动开发原理；",
                "热衷 iOS 应用开发。"
            ],
            "1": [
                "N 年 SEO优化经验；",
                //                "了解SEO优化；",
                "热衷 SEO 搜索引擎优化。"
            ]
        ]
    )
    
    

    // 个人简介
    templete.information.set(
        [
            "目前就职于考拉先生，主要负责iOS的开发、维护工作.",
            "自 2013 年开始接触 iOS 开发，至今已有 4 年时间，熟悉Swift、Objective-C 代码的编写。熟悉大部分 iOS 开发与调试工具，理解 iOS App 结构与运行机制，注重代码质量与执行效率。",
            "了解常见移动 App 架构，长期使用 Swift 与 Objective-C 进行混合开发，熟悉各类常用第三方库的使用。",
            "熟悉 iOS 库的开发与发布，了解怎样利用 CocoaPods／Swift Package Manager／Cathage 进行打包与集成，业余时间热爱编写开源代码。熟悉持续集成，能够编写 Jenkins、Travis CI 等持续集成工具的配置。",
            "寻觅一份 iOS 开发的全职正式工作，也可以根据具体情况考虑其它相关岗位。".strong()
        ]
    )

    // 项目经历
    templete.project.set(
        [
            [
                "category": "考拉先生科技有限公司（2015.11 — 至今）",
                "pro_name": "iOS 团队开发和维护经验：考拉商圈",
                "pro_desc": [
                    "参与日常技术方案选型、业务迭代排期、线上异常监控、BUG 修复等工作；",
                    "从 3.5 上架 AppStore 开始参与开发和维护工作至今，主要完成了新模块的开发、部分旧模块的重构、统计,内存检测的接入、蓝牙打印,开店,登录,广告弹屏,多账号切换,用户设置,店铺管理等工作"
                ]
            ],
            [
                "category": "星润科技有限公司（2014.9 — 2015.10）",
                "pro_name": "iOS 团队开发经验：附近生活",
                "pro_desc": [
                    "从加入公司开始学习 iOS 开发，积累了一定的 iOS 开发和维护经验；",
                    "团队协作 App 从无到有的开发、上架以及后续的升级维护工作，基本实现了一个电商 App 功能；",
                ]
            ]
        ]
    )
    
    templete.skillsDescription.set(
        [
            "有良好的代码编写规范，","对应用工作机制较熟悉，",
            "有良好的程序开发能力，","积攒了丰富的调试经验，",
            "热衷于用代码解决问题，","熟练使用版本控制工具，",
            "热衷于用代码解决问题，","关注科技行业前沿技术。"
        ]
    )
}

main()
