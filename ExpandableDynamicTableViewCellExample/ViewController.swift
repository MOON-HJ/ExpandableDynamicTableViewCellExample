//
//  ViewController.swift
//  ExpandableDynamicTableViewCellExample
//
//  Created by Soso on 12/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxViewBinder
import RxViewController

class ViewController: UIViewController, BindView{
	typealias ViewBinder = CellViewModel

	let disposeBag = DisposeBag()
	@IBOutlet weak var tableView: UITableView!

	var cell: NoticeCell!

	override func viewDidLoad() {
		super.viewDidLoad()

	}


	required init?(coder: NSCoder) {
		super.init(coder: coder)
		self.viewBinder = CellViewModel()
	}

	func state(viewBinder: ViewBinder) {
		self.tableView.rx
			.setDelegate(self)
			.disposed(by: disposeBag)

		self.tableView.register(NoticeCell.self, forCellReuseIdentifier: NoticeCell.id)
		viewBinder.state
			.fetchInfo
			.asObservable()
			.bind(to: tableView.rx.items){ tableView, _, item -> UITableViewCell in
				guard let cell = tableView.dequeueReusableCell(withIdentifier: NoticeCell.id) as? NoticeCell else { return UITableViewCell()}
				cell.configure(item)
				return cell

			}
			.disposed(by: disposeBag)

		viewBinder.state
			.afterToggleRelay
			.drive(onNext: { [weak self] in
				self?.tableView.beginUpdates()
				self?.tableView.endUpdates()
			}).disposed(by: disposeBag)

		//		viewBinder.state
		//			.asObservable()
		//			.subscribe(onNext: { [weak self] _ in
		//				self?.tableView.beginUpdates()
		//				self?.tableView.endUpdates()
		//			})
		//			.disposed(by: disposeBag)
	}

	func command(viewBinder: ViewBinder) {
		self.tableView.rx.itemSelected
			.map{ ViewBinder.Command.toggle($0)}
			.bind(to: viewBinder.command)
			.disposed(by: disposeBag)
		//			.map{ [weak self] (indexPath) in
		//				if let row = indexPath.element?.row {
		//					_ = viewBinder.Command.toggle(row)
		//					self?.tableView.beginUpdates()
		//					self?.tableView.endUpdates()
		//				}}.bind(to: viewBinder.command)

		self.rx.viewWillAppear
			.map{ _ in ViewBinder.Command.fetch}
			.bind(to: viewBinder.command)
			.disposed(by: disposeBag)
	}

	func heightForData(_ data: CellDTO, index: IndexPath) -> CGFloat {
		if cell == nil {
			cell = tableView.dequeueReusableCell(withIdentifier: NoticeCell.id) as? NoticeCell
		}
		cell.configure(data)
		cell.setNeedsLayout()
		cell.layoutIfNeeded()

		let sizeTop = cell.viewTop.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize)
		let sizeBottom = cell.viewBottom.systemLayoutSizeFitting(UIView.layoutFittingExpandedSize)

		if data.isExpanded {
			return sizeTop.height + sizeBottom.height
		} else {
			return sizeTop.height
		}
	}

}

extension ViewController: UITableViewDelegate {
	func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		guard let items = viewBinder?.items[indexPath.row] else { return 0.0}
		return self.heightForData(items, index: indexPath)
	}

}
