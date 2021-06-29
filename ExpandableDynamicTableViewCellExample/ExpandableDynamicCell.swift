//
//  ExpandableDynamicCell.swift
//  ExpandableDynamicTableViewCellExample
//
//  Created by Soso on 12/03/2020.
//  Copyright © 2020 Soso. All rights reserved.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa
import RxViewBinder
import SnapKit
import Then


struct CellDTO {
	let titleText: String
	let descriptionText: String
	let contentText: String
	var isExpanded: Bool

	init(titleText: String, descriptionText: String, contentText: String) {
		self.titleText = titleText
		self.descriptionText = descriptionText
		self.contentText = contentText
		self.isExpanded = false
	}

	mutating func toggle() {
		isExpanded = !isExpanded
	}
}

class CellViewModel: ViewBindable {
	enum Command {
		case fetch
		case toggle(IndexPath)
	}

	struct Action {
		let fetchAction: BehaviorRelay<[CellDTO]> = BehaviorRelay(value: .init())
		let afterToggleAction: PublishRelay<Void> = PublishRelay()
	}

	struct State {
		let fetchInfo: Driver<[CellDTO]>
		let afterToggleRelay: Driver<Void>
		init(action: Action) {
			fetchInfo = action.fetchAction.asDriver(onErrorJustReturn: .init())
			afterToggleRelay = action.afterToggleAction.asDriver(onErrorJustReturn: ())
		}

	}

	let action = Action()
	lazy var state = State(action: action)
	var items: [CellDTO] = []

	func binding(command: Command) {
		switch command {
			case .fetch :
				Observable<[CellDTO]>.just(
					[
						CellDTO(titleText: "title", descriptionText: "0000/00/00", contentText: "content oiqwj oiqj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowjw oijqwo jqownd qmwnd ljwnef ekf jha soiwej lakf ioqewjlaksdiowefl kqepfoqwj qwm ;qwoi qowqw iqwj dlqkwdm ioqwj mqwkm ;qwok poqkw;qw;l qowk almwd oakwlaw; l"),
                        CellDTO(titleText: "titletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitletitle", descriptionText: "0000/00/00", contentText: "content oiqwj oiqjw oijqwo jqownd qmwnd ljwnef ekf jha soiwej lakf ioqewjlaksdiowefl kqepfoqwj qwm ;qwoi qowqw iqwj dlqkwdm ioqwj mqwkm ;qwok poqkw;qw;l qowk almwd oakwlaw; l"),
                        CellDTO(titleText: "title", descriptionText: "0000/00/00", contentText: "content oiqwj oiqjw oijqwo jqownd qmwnd ljwnef ekf jha soiwej lakf ioqewjlaksdiowefl kqepfoqwj qwm ;qwoi qowqw iqwj dlqkwdm ioqwj mqwkm ;qwok poqkw;qw;l qowk almwd oakwlaw; l"),
                        CellDTO(titleText: "title title title title title title title title title title title title title title title title title title title title title title", descriptionText: "0000/00/00", contentText: "content oiqwj oiqjw oijqwo jqownd qmwnd ljwnef ekf jha soiwej lakf ioqewjlaksdiowefl kqepfoqwj qwm ;qwoi qowqw iqwj dlqkwdm ioqwj mqwkm ;qwok poqkw;qw;l qowk almwd oakwlaw; l pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj"),
                        CellDTO(titleText: "title", descriptionText: "0000/00/00", contentText: "content oiqwj oiqjw oijqwo jqownd qmwnd ljwnef ekf jha soiwej lakf ioqewjlaksdiowefl kqepfoqwj qwm ;qwoi qowqw iqwj dlqkwdm ioqwj mqwkm ;qwok poqkw;qw;l qowk almwd oak pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowjwlaw; l"),
                        CellDTO(titleText: "title", descriptionText: "0000/00/00", contentText: "content"),
                        CellDTO(titleText: "title", descriptionText: "0000/00/00", contentText: "content"),

//						CellDTO(titleText: "title laksd lka wklj lkawj owj pqwj qowj qowj pqowj pqowj pqojw pow", descriptionText: "description wio jqwij oiwj oqijw oiqjw oiqjw oijwoiqj oiqjwi ", contentText: "content oiqwj oiqj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowjw oijqwo jqownd qmwnd ljwnef ekf jha soiwej lakf ioqewjlaksdiowefl kqepfoqwj qwm ;qwoi qowqw iqwj dlqkwdm ioqwj mqwkm ;qwok poqkw;qw;l qowk almwd oakwlaw; l"),
//						CellDTO(titleText: "title laksd lka wklj lkawj owj pqwj qowj qowj pqowj pqowj pqojw pow", descriptionText: "description wio jqwij oiwj oqijw oiqjw oiqjw oi pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowjjwoiqj oiqjwi ", contentText: "content oiqwj oiqjw oijqwo jqownd qmwnd ljwnef ekf jha soiwej lakf ioqewjlaksdiowefl kqepfoqwj qwm ;qwoi qowqw iqwj dlqkwdm ioqwj mqwkm ;qwok poqkw;qw;l qowk almwd oakwlaw; l"),
//						CellDTO(titleText: "title laksd lka wklj lkawj owj pqwj qowj qowj pqowj pqowj pqojw p pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowjow", descriptionText: "description wio jqwij oiwj oqijw oiqjw oiqjw oijwoiqj oiqjwi ", contentText: "content oiqwj oiqjw oijqwo jqownd qmwnd ljwnef ekf jha soiwej lakf ioqewjlaksdiowefl kqepfoqwj qwm ;qwoi qowqw iqwj dlqkwdm ioqwj mqwkm ;qwok poqkw;qw;l qowk almwd oakwlaw; l"),
//						CellDTO(titleText: "title laksd lka wklj lkawj owj pqwj qowj qowj pqowj pqowj pqojw pow", descriptionText: "description wio jqwij oiwj oqijw oiqjw oiqjw oijwoiqj oiqjwi ", contentText: "content oiqwj oiqjw oijqwo jqownd qmwnd ljwnef ekf jha soiwej lakf ioqewjlaksdiowefl kqepfoqwj qwm ;qwoi qowqw iqwj dlqkwdm ioqwj mqwkm ;qwok poqkw;qw;l qowk almwd oakwlaw; l pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowj"),
//						CellDTO(titleText: "title laksd lka wklj lkawj owj pqwj qowj qowj pqowj pqowj pqojw pow", descriptionText: "description wio jqwij oiwj oqijw oiqjw oiqjw oijwoiqj oiqjwi ", contentText: "content oiqwj oiqjw oijqwo jqownd qmwnd ljwnef ekf jha soiwej lakf ioqewjlaksdiowefl kqepfoqwj qwm ;qwoi qowqw iqwj dlqkwdm ioqwj mqwkm ;qwok poqkw;qw;l qowk almwd oak pqwj qowj qowj pqowj pqwj qowj qowj pqowj pqwj qowj qowj pqowjwlaw; l")

					]
				)
				.compactMap{$0}
				.debug()
				.subscribe(onNext: { [weak self] in
					self?.items = $0
					self?.action.fetchAction.accept($0)
				})
				.disposed(by: disposeBag)

			case .toggle(let indexPath):
				items[indexPath.item].toggle()
				self.action.afterToggleAction.accept(())

		}
	}
}

class NoticeCell: UITableViewCell {
	let view = UIView().then{
        $0.backgroundColor = .darkGray
		$0.clipsToBounds = true
//		$0.isOpaque = true
		$0.autoresizingMask = .flexibleBottomMargin
	}

	let viewTop = UIView().then{
		$0.backgroundColor = .lightGray
//		$0.isOpaque = true
        $0.sizeToFit()
	}

	let viewBottom = UIView().then{
		$0.isOpaque = true

	}

	let titleLabel = UILabel().then{
		$0.backgroundColor = .systemYellow
		$0.isOpaque = false
		$0.numberOfLines = 0
        $0.sizeToFit()
	}

	let dateLabel = UILabel().then{
		$0.backgroundColor = .systemOrange
		$0.isOpaque = false
		$0.numberOfLines = 0
        $0.sizeToFit()
	}

	let contentLabel = UILabel().then{
		$0.backgroundColor = .systemRed
		$0.numberOfLines = 0
		$0.isOpaque = false
		$0.autoresizingMask = .flexibleBottomMargin

	}

	static let id = "cell"

	var disposeBag = DisposeBag()

	override func prepareForReuse() {
		super.prepareForReuse()
		disposeBag = DisposeBag()

		titleLabel.text = nil
		dateLabel.text = nil
		contentLabel.text = nil
        contentLabel.isEnabled = false

	}


	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		self.clipsToBounds = true

		self.contentView.isOpaque = false
		self.contentView.clipsToBounds = true
		self.clipsToBounds = true

		[view, viewTop].forEach{
			self.contentView.addSubview($0)
		}

		[titleLabel, dateLabel].forEach{
			self.viewTop.addSubview($0)
		}

		[viewBottom].forEach{
			self.view.addSubview($0)
		}

		[contentLabel].forEach{
			self.viewBottom.addSubview($0)
		}
		

		view.snp.makeConstraints{
			$0.top.equalTo(viewTop.snp.top)
            $0.left.right.bottom.top.equalToSuperview()
            $0.bottom.equalTo(viewBottom.snp.bottom)
		}

		viewTop.snp.makeConstraints{
            $0.left.right.top.equalToSuperview()
		}

		viewBottom.snp.makeConstraints{
			$0.left.right.bottom.equalToSuperview()
            $0.top.equalTo(viewTop.snp.bottom)
		}

		titleLabel.snp.makeConstraints{
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.top.equalToSuperview().offset(20).priority(.required)
		}

		dateLabel.snp.makeConstraints{
            $0.bottom.equalToSuperview().priority(.required)
            $0.left.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
			$0.top.equalTo(titleLabel.snp.bottom).offset(20).priority(.required)
            $0.bottom.equalToSuperview().offset(-20).priority(.required)
		}

		contentLabel.snp.makeConstraints{
            $0.left.top.equalToSuperview().offset(20)
            $0.right.equalToSuperview().offset(-20)
            $0.bottom.equalTo(contentView.snp.bottom).offset(-20).priority(.low)
		}

        viewTop.setContentHuggingPriority(.required, for: .vertical)
		titleLabel.setContentHuggingPriority(.required, for: .horizontal)
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        

		dateLabel.setContentHuggingPriority(.required, for: .horizontal)
		dateLabel.setContentHuggingPriority(.required, for: .vertical)

		contentLabel.setContentHuggingPriority(.defaultHigh, for: .horizontal)
		contentLabel.setContentHuggingPriority(.defaultLow, for: .vertical)


	}

	func configure(_ data: CellDTO) {
		titleLabel.text = data.titleText
		dateLabel.text = data.descriptionText
		contentLabel.text = data.contentText
        contentLabel.isEnabled = !data.isExpanded
        
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}



}
