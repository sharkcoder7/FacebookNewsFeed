//
//  NavigationBar.swift
//
//

import UIKit

@IBDesignable open class NavigationBar: UIView {
    //MARK: - Declarations -
    @IBOutlet var lblTitle : UILabel!
    @IBOutlet var view : UIView!
    @IBOutlet var btnLeft : UIButton!
    @IBOutlet var btnRight : UIButton!
    
    //MARK: - Inspecrables -
    @IBInspectable var bgColor: UIColor! {
        didSet {
            view.backgroundColor = bgColor
        }
    }
    @IBInspectable var title: String!{
        didSet {
            lblTitle.text = title
        }
    }
    @IBInspectable var leftImage: UIImage! {
        didSet {
            btnLeft.setImage(leftImage, for: UIControlState())
        }
    }
    @IBInspectable var rightImage: UIImage! {
        didSet {
            btnRight.setImage(rightImage, for: UIControlState())
        }
    }
   /* @IBInspectable var leftInset: CGRect! {
        didSet {
            btnLeft.imageEdgeInsets = UIEdgeInsets(top: leftInset.origin.y,left: leftInset.origin.x, bottom: leftInset.size.height, right: leftInset.size.width)
        }
    }
    @IBInspectable var rightInset: CGRect! {
        didSet {
            btnRight.imageEdgeInsets = UIEdgeInsets(top: rightInset.origin.y,left: rightInset.origin.x, bottom: rightInset.size.height, right: rightInset.size.width)
        }
    }*/
    
    /** set actions for left and right button
    @param target self(viewcontroller)
    @param leftButtonSelector selector for left button or nil for default action
    @param rightButtonSelector selector for right button or nil for default action
    */
    
    var currentTarget: UIViewController!
    
    //MARK: - SetUp -
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        setup()
    }
    
    func setup()
    {
        let bundle = Bundle(for:type(of: self))
        let nib = UINib(nibName: "NavigationBar", bundle: bundle)
        self.view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        self.frame = view.bounds
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.addSubview(view)
    }
    
    //MARK: - Header Set -
    func HeaderSet(_ target: UIViewController,leftBtnSlector: Selector,rightBtnSelector: Selector)
    {
        currentTarget = target
        
        let leftTarget = leftBtnSlector.description == "openSideMenu" || leftBtnSlector.description == "goBack" ? self : target
        let rightTarget = rightBtnSelector.description == "openSideMenu" || rightBtnSelector.description == "goBack" ? self : target
        
        self.btnLeft.addTarget(leftTarget, action: leftBtnSlector, for: UIControlEvents.touchUpInside)
        self.btnRight.addTarget(rightTarget, action: rightBtnSelector, for: UIControlEvents.touchUpInside)
        
        if leftBtnSlector.description == "openSideMenu" {
            //Add Left Menu//
            let menuLeftNavController = storyBoard_SideMenu.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController
            menuLeftNavController.leftSide = true
            SideMenuManager.menuLeftNavigationController = menuLeftNavController
            
            // Enable gestures. The left and/or right menus must be set up above for these to work.
            // Note that these continue to work on the Navigation Controller independent of the View Controller it displays!
            SideMenuManager.menuAddPanGestureToPresent(toView: target.navigationController!.navigationBar)
            SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: target.navigationController!.view)
            
            SideMenuManager.menuPresentMode = .menuSlideIn   //.ViewSlideOut
            //Add Left Menu End//
        }
    }
    
    //MARK: - Header Button Events -
    func openSideMenu() {
        currentTarget.view.endEditing(true)
        currentTarget.present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)
    }
    
    func goBack()
    {
        currentTarget.navigationController!.popViewController(animated: true)
    }

}
