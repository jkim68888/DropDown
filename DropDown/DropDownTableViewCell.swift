import SnapKit

class DropDownTableViewCell: UITableViewCell {
    static let identifier = "DropDownCell"
    
    var menuLabel = UILabel()

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setConstraints()
    }

    private func setUI() {
        contentView.addSubview(menuLabel)
    }
    
    private func setConstraints() {
        menuLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview().offset(20)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
}
