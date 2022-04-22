//
//  AppDatePickerView.swift
//  TimeRecord
//
//  Created by wl on 2022/3/9.
//

import UIKit
import SnapKit

class PopUpDatePickerView: UIView {
    
    var changeClosure: ((Date) -> Void)?
    
    let contentView = UIView()
    let datePicker = UIDatePicker()
    let button = UIButton()
    
    var animator: UIViewPropertyAnimator?
    var animationDuration = 0.25
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        backgroundColor = .black.withAlphaComponent(0.4)
        
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 15
        contentView.layer.masksToBounds = false
        contentView.layer.shadowOffset = CGSize(width: 0, height: 2)
        contentView.layer.shadowRadius = 5
        contentView.layer.shadowOpacity = 0.2
        contentView.layer.shadowColor = UIColor.black.cgColor
        addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-10)
            make.left.right.equalToSuperview().inset(5)
        }
        
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.backgroundColor = .black
        button.setTitle(NSLocalizedString("go", comment: ""), for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        contentView.addSubview(button)
        button.snp.makeConstraints { (make) in
            make.bottom.equalToSuperview().offset(-10)
            make.left.right.equalToSuperview().inset(15)
            make.height.equalTo(60)
        }
        
        datePicker.tintColor = .black
        datePicker.addTarget(self, action: #selector(dateChangeAction), for: .valueChanged)
        contentView.addSubview(datePicker)
        datePicker.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.bottom.equalTo(button.snp.top).offset(-10)
            make.left.right.equalToSuperview().inset(15)
        }
        
        if #available(iOS 14.0, *) {
            datePicker.preferredDatePickerStyle = .inline
        }

        let t = UITapGestureRecognizer(target: self, action: #selector(tapHandler(_:)))
        // https://stackoverflow.com/questions/64176324/unable-to-tap-days-in-ios-14-inline-datepicker
        t.cancelsTouchesInView = false
        addGestureRecognizer(t)

        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(panHandler(_:)))
        contentView.addGestureRecognizer(panGestureRecognizer)
    }
    
    @objc func tapHandler(_ sender: UITapGestureRecognizer) {
        guard
              !self.contentView.frame.contains(sender.location(in: self))  else {
            return
        }
        hide()
    }
    
    @objc func panHandler(_ sender: UIPanGestureRecognizer) {
        
        let translation = sender.translation(in: self)
        let fraction = max(0.001, min(0.999, translation.y / contentView.bounds.height))
    
        switch sender.state {
        case .began:
            animator = UIViewPropertyAnimator.init(duration: animationDuration, curve: .easeIn) {
                self.backgroundColor = .black.withAlphaComponent(0)
                self.contentView.snp.updateConstraints { make in
                    make.bottom.equalTo(self.safeAreaLayoutGuide).offset(self.contentView.bounds.height + CGFloat.bottomPadding)
                }
                self.layoutIfNeeded()
            }
            animator?.addCompletion({ position in
                sender.isEnabled = true
                switch position {
                case .end:
                    self.hide(animation: false)
                case .start:
                    // 重置位置
                    self.backgroundColor = .black.withAlphaComponent(0.2)
                    self.contentView.snp.updateConstraints { make in
                        make.bottom.equalTo(self.safeAreaLayoutGuide).offset(-10)
                    }
                    self.layoutIfNeeded()
                case .current:
                    break
                @unknown default:
                    break
                }
            })
        case .changed:
            animator?.fractionComplete = fraction
        case .ended, .failed, .cancelled:
            sender.isEnabled = false
            let velocity = sender.velocity(in: self)
            let finishAnimation = fraction >= 0.5 || velocity.y > 100
            
            if finishAnimation {
                animator?.continueAnimation(withTimingParameters: nil, durationFactor: 1.0 - fraction)
            } else {
                animator?.isReversed = true
                animator?.startAnimation()
            }
        case .possible:
            break
        @unknown default:
            break
        }
    }
    
    @objc func buttonAction() {
        changeClosure?(datePicker.date)
        hide()
    }
    
    @objc func dateChangeAction() {
        print(datePicker.date)
    }
}

extension PopUpDatePickerView {
    
    static func show(animation: Bool = true) -> PopUpDatePickerView {
        let view = PopUpDatePickerView()
        UIApplication.shared.windows.first(where: {$0.isKeyWindow})?.addSubview(view)
        view.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        view.layoutIfNeeded()
        view.contentView.snp.updateConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(view.contentView.bounds.height)
        }
        view.layoutIfNeeded()
        
        if animation {
            view.backgroundColor = .black.withAlphaComponent(0)
            UIView.animate(withDuration: view.animationDuration, delay: 0, options: .curveEaseOut) {
                view.backgroundColor = .black.withAlphaComponent(0.2)
                view.contentView.snp.updateConstraints { make in
                    make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-10)
                }
                view.layoutIfNeeded()
            }
        }
        return view
    }
    
    func hide(animation: Bool = true) {
        if animation {
            backgroundColor = .black.withAlphaComponent(0.2)
            UIView.animate(withDuration: animationDuration, delay: 0, options: .curveEaseIn) {
                self.backgroundColor = .black.withAlphaComponent(0)
                self.contentView.snp.updateConstraints { make in
                    make.bottom.equalTo(self.safeAreaLayoutGuide).offset(self.contentView.bounds.height + CGFloat.bottomPadding)
                }
                self.layoutIfNeeded()
            } completion: { _ in
                self.removeFromSuperview()
            }
        } else {
            removeFromSuperview()
        }
    }
    
}
