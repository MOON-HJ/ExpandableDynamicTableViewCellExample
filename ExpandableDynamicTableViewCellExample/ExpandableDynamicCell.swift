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
						CellDTO(titleText: "제목제목", descriptionText: "날짜날짜", contentText: "내용내용"),
						CellDTO(titleText: "나나나나", descriptionText: "니니니니니", contentText: "노노노노노노노노"),
						CellDTO(titleText: "다다다다", descriptionText: "다다다다다", contentText: "다다다다다다다다"),
						CellDTO(titleText: "라라라라", descriptionText: "리리리리리", contentText: "로로로로로로로로"),
						CellDTO(titleText: "마마마마", descriptionText: "미미미미미", contentText: "모모모모모모모모"),
						CellDTO(titleText: "바바바바", descriptionText: "비비비비비", contentText: "보보보보보보보보"),
						CellDTO(titleText: "가가가가", descriptionText: "기기기기기", contentText: "고고고고고고고고"),
						CellDTO(titleText: "나나나나", descriptionText: "니니니니니", contentText: "노노노노노노노노"),
						CellDTO(titleText: "다다다다", descriptionText: "다다다다다", contentText: "다다다다다다다다"),
						CellDTO(titleText: "라라라라", descriptionText: "리리리리리", contentText: "로로로로로로로로"),
						CellDTO(titleText: "마마마마", descriptionText: "미미미미미", contentText: "모모모모모모모모"),
						CellDTO(titleText: "바바바바", descriptionText: "비비비비비", contentText: "보보보보보보보보"),
						CellDTO(titleText: "가가가가", descriptionText: "기기기기기", contentText: "고고고고고고고고"),
						CellDTO(titleText: "나나나나", descriptionText: "니니니니니", contentText: "노노노노노노노노"),
						CellDTO(titleText: "다다다다", descriptionText: "다다다다다", contentText: "다다다다다다다다"),
						CellDTO(titleText: "라라라라", descriptionText: "리리리리리", contentText: "로로로로로로로로"),
						CellDTO(titleText: "마마마마", descriptionText: "미미미미미", contentText: "모모모모모모모모"),
						CellDTO(titleText: "바바바바", descriptionText: "비비비비비", contentText: "보보보보보보보보"),
						CellDTO(titleText: "가가가가", descriptionText: "기기기기기", contentText: "고고고고고고고고"),
						CellDTO(titleText: "나나나나", descriptionText: "니니니니니", contentText: "노노노노노노노노"),
						CellDTO(titleText: "다다다다", descriptionText: "다다다다다", contentText: "다다다다다다다다"),
						CellDTO(titleText: "라라라라", descriptionText: "리리리리리", contentText: "로로로로로로로로"),
						CellDTO(titleText: "마마마마", descriptionText: "미미미미미", contentText: "모모모모모모모모"),
						CellDTO(titleText: "바바바바", descriptionText: "비비비비비", contentText: "보보보보보보보보"),
						CellDTO(titleText: "가가가가", descriptionText: "기기기기기", contentText: "고고고고고고고고"),
						CellDTO(titleText: "나나나나", descriptionText: "니니니니니", contentText: "노노노노노노노노"),
						CellDTO(titleText: "다다다다", descriptionText: "다다다다다", contentText: "다다다다다다다다"),
						CellDTO(titleText: "라라라라", descriptionText: "리리리리리", contentText: "로로로로로로로로"),
						CellDTO(titleText: "마마마마", descriptionText: "미미미미미", contentText: "모모모모모모모모"),
						CellDTO(titleText: "바바바바", descriptionText: "비비비비비", contentText: "보보보보보보보보"),
						CellDTO(titleText: "가가가가", descriptionText: "기기기기기", contentText: "고고고고고고고고"),
						CellDTO(titleText: "나나나나", descriptionText: "니니니니니", contentText: "노노노노노노노노"),
						CellDTO(titleText: "다다다다", descriptionText: "다다다다다", contentText: "다다다다다다다다"),
						CellDTO(titleText: "라라라라", descriptionText: "리리리리리", contentText: "로로로로로로로로"),
						CellDTO(titleText: "마마마마", descriptionText: "미미미미미", contentText: "모모모모모모모모"),
						CellDTO(titleText: "바바바바", descriptionText: "비비비비비", contentText: "보보보보보보보보"),
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

//class ExpandableDynamicCell: UITableViewCell {
//
//    @IBOutlet weak var viewTop: UIView!
//    @IBOutlet weak var viewBottom: UIView!
//    @IBOutlet weak var labelTitle: UILabel!
//    @IBOutlet weak var labelDescription: UILabel!
//    @IBOutlet weak var labelContent: UILabel!
//
//    override func prepareForReuse() {
//        super.prepareForReuse()
//
//        labelTitle.text = nil
//        labelDescription.text = nil
//        labelContent.text = nil
//    }
//
//    func configure(_ data: CellDTO) {
//        labelTitle.text = data.titleText
//        labelDescription.text = data.descriptionText
//        labelContent.text = data.contentText
//    }
//
//
//
//}

class NoticeCell: UITableViewCell {
	let view = UIView().then{
		$0.backgroundColor = .red
	}
	let viewTop = UIView()
	let viewBottom = UIView().then{
		$0.backgroundColor = .green
	}

	let titleLabel = UILabel().then{
		$0.sizeToFit()
		//		$0.backgroundColor = .purple

	}

	let dateLabel = UILabel().then{
		$0.sizeToFit()
		$0.backgroundColor = .systemBlue
	}


	let contentLabel = UILabel().then{
		$0.sizeToFit()
		$0.backgroundColor = .magenta

	}

	static let id = "cell"

	var disposeBag = DisposeBag()

	override func prepareForReuse() {
		disposeBag = DisposeBag()

	}

	override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
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
			$0.left.equalTo(16)
			$0.right.equalTo(-16)
			$0.top.equalTo(viewTop.snp.top)
			$0.bottom.equalTo(-16)
		}

		viewTop.snp.makeConstraints{
			$0.top.left.equalTo(16)
			$0.right.equalTo(-16)
			$0.top.equalTo(16)
		}

		viewBottom.snp.makeConstraints{
			$0.left.right.equalToSuperview()
			$0.top.equalTo(viewTop.snp.bottom)
			$0.bottom.equalToSuperview()
		}

		titleLabel.snp.makeConstraints{
			$0.top.left.right.equalToSuperview()
			$0.bottom.equalTo(16)
		}

		dateLabel.snp.makeConstraints{
			$0.bottom.left.right.equalToSuperview()
			$0.top.equalTo(16)
		}

		contentLabel.snp.makeConstraints{
			$0.top.bottom.right.equalToSuperview()
		}

		titleLabel.setContentHuggingPriority(.required, for: .horizontal)
		titleLabel.setContentHuggingPriority(.required, for: .vertical)

		dateLabel.setContentHuggingPriority(.required, for: .horizontal)
		dateLabel.setContentHuggingPriority(.required, for: .vertical)

		contentLabel.setContentHuggingPriority(.required, for: .horizontal)
		contentLabel.setContentHuggingPriority(.required, for: .vertical)


	}

	func configure(_ data: CellDTO) {
		titleLabel.text = data.titleText
		dateLabel.text = data.descriptionText
		contentLabel.text = data.contentText
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}



}
