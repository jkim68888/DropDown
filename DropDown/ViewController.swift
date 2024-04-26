import SnapKit

class ViewController: UIViewController {
    private let menus: [String] = ["메뉴1", "메뉴2", "메뉴3", "메뉴4", "메뉴5"]
    
    private let chooseMenuBtn: UIButton = UIButton()
    private let dimView: UIView = UIView()
    private let dropDownView: UITableView = UITableView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        setConstraints()
        
        dropDownView.register(DropDownTableViewCell.self, forCellReuseIdentifier: DropDownTableViewCell.identifier)
        dropDownView.dataSource = self
        dropDownView.delegate = self
        
        chooseMenuBtn.addTarget(self, action: #selector(chooseMenuBtnTapped), for: .touchUpInside)
        dimView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dimViewTapped)))
    }

    private func setUI() {
        self.view.backgroundColor = .white
        
        self.view.addSubviews([chooseMenuBtn, dimView, dropDownView])
        
        chooseMenuBtn.setTitle("메뉴1", for: .normal)
        chooseMenuBtn.setTitleColor(.black, for: .normal)
        chooseMenuBtn.titleLabel?.font = .systemFont(ofSize: 20, weight: .medium)
        chooseMenuBtn.tintColor = .black
        
        // 버튼 이미지 오른쪽으로 두기 위함
        var configuration = UIButton.Configuration.plain()
        configuration.imagePadding = 10
        configuration.image = UIImage(systemName: "arrowtriangle.down.fill", withConfiguration: UIImage.SymbolConfiguration(pointSize: 15))
        configuration.imagePlacement = .trailing
        chooseMenuBtn.configuration = configuration
        
        dimView.backgroundColor = .black
        dimView.layer.opacity = 0.2
        dimView.isHidden = true
        
        dropDownView.isHidden = true
    }
    
    private func setConstraints() {
        chooseMenuBtn.snp.makeConstraints {
            $0.top.equalToSuperview().offset(100)
            $0.leading.equalToSuperview().offset(20)
        }
        
        dimView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        dropDownView.snp.makeConstraints {
            $0.top.equalTo(chooseMenuBtn.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(20)
            $0.width.equalTo(230)
            $0.height.equalTo(50 * menus.count)
        }
    }
    
    private func showDropDown() {
        UIView.animate(withDuration: 0.3, animations: {
            self.chooseMenuBtn.imageView?.transform = CGAffineTransformMakeRotation(Double.pi)
        })
        
        dimView.isHidden = false
        dropDownView.isHidden = false
    }
    
    private func hideDropDown() {
        UIView.animate(withDuration: 0.3, animations: {
            self.chooseMenuBtn.imageView?.transform = CGAffineTransformMakeRotation(Double.pi - 3.14159)
        })
        
        dimView.isHidden = true
        dropDownView.isHidden = true
    }
    
    @objc private func chooseMenuBtnTapped() {
        showDropDown()
    }
    
    @objc private func dimViewTapped() {
        hideDropDown()
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menus.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: DropDownTableViewCell.identifier, for: indexPath) as? DropDownTableViewCell else { fatalError("unable to dequeue cell") }
        
        cell.menuLabel.text = menus[indexPath.row]
    
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chooseMenuBtn.setTitle(menus[indexPath.row], for: .normal)
        hideDropDown()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
