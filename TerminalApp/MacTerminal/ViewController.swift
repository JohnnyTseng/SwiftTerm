//
//  ViewController.swift
//  MacTerminal
//
//  Created by Miguel de Icaza on 3/11/20.
//  Copyright © 2020 Miguel de Icaza. All rights reserved.
//

import Cocoa
import SwiftTerm

class ViewController: NSViewController, LocalProcessTerminalViewDelegate, NSUserInterfaceValidations {
    @IBOutlet var loggingMenuItem: NSMenuItem?

    var changingSize = false
    var logging: Bool = false

    func sizeChanged(source: LocalProcessTerminalView, newCols: Int, newRows: Int) {
        if changingSize {
            return
        }
        changingSize = true
        //var border = view.window!.frame - view.frame
        var newFrame = terminal.getOptimalFrameSize ()
        let windowFrame = view.window!.frame
        
        newFrame = CGRect (x: windowFrame.minX, y: windowFrame.minY, width: newFrame.width, height: windowFrame.height - view.frame.height + newFrame.height)

        view.window?.setFrame(newFrame, display: true, animate: true)
        changingSize = false
    }
    
    func setTerminalTitle(source: LocalProcessTerminalView, title: String) {
        view.window?.title = title
    }
    
    func processTerminated(source: TerminalView, exitCode: Int32?) {
        view.window?.close()
        if let e = exitCode {
            print ("Process terminated with code: \(e)")
        } else {
            print ("Process vanished")
        }
    }
    var terminal: LocalProcessTerminalView!

    static var lastTerminal: LocalProcessTerminalView!
    
    func updateLogging ()
    {
        let path = logging ? "/Users/miguel/Downloads/Logs" : nil
        terminal.setHostLogging (directory: path)
        NSUserDefaultsController.shared.defaults.set (logging, forKey: "LogHostOutput")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        terminal = LocalProcessTerminalView(frame: view.frame)
        
        ViewController.lastTerminal = terminal
        terminal.processDelegate = self

        terminal.feed(text: "\u{1B}[H\u{1B}[34;47m 作者 \u{1B}[0;44m charlie19905 (charlie1990507)                         \u{1B}[34;47m 看板 \u{1B}[0;44m Gossiping \u{1B}[m\u{1B}[K\r\n\u{1B}[34;47m 標題 \u{1B}[0;44m [問卦] 關於盜帳號集團...(內有大奶圖                                    \r\n\u{1B}[34;47m 時間 \u{1B}[0;44m Tue May  5 08:08:46 2020                                               \u{1B}[m\u{1B}[K\r\n  \u{08}\u{08}\u{1B}[36m─\u{1B}[4;3H  \u{08}\u{08}─\u{1B}[4;5H  \u{08}\u{08}─\u{1B}[4;7H  \u{08}\u{08}─\u{1B}[4;9H  \u{08}\u{08}─\u{1B}[4;11H  \u{08}\u{08}─\u{1B}[4;13H  \u{08}\u{08}─\u{1B}[4;15H  \u{08}\u{08}─\u{1B}[4;17H  \u{08}\u{08}─\u{1B}[4;19H  \u{08}\u{08}─\u{1B}[4;21H  \u{08}\u{08}─\u{1B}[4;23H  \u{08}\u{08}─\u{1B}[4;25H  \u{08}\u{08}─\u{1B}[4;27H  \u{08}\u{08}─\u{1B}[4;29H  \u{08}\u{08}─\u{1B}[4;31H  \u{08}\u{08}─\u{1B}[4;33H  \u{08}\u{08}─\u{1B}[4;35H  \u{08}\u{08}─\u{1B}[4;37H  \u{08}\u{08}─\u{1B}[4;39H  \u{08}\u{08}─\u{1B}[4;41H  \u{08}\u{08}─\u{1B}[4;43H  \u{08}\u{08}─\u{1B}[4;45H  \u{08}\u{08}─\u{1B}[4;47H  \u{08}\u{08}─\u{1B}[4;49H  \u{08}\u{08}─\u{1B}[4;51H  \u{08}\u{08}─\u{1B}[4;53H  \u{08}\u{08}─\u{1B}[4;55H  \u{08}\u{08}─\u{1B}[4;57H  \u{08}\u{08}─\u{1B}[4;59H  \u{08}\u{08}─\u{1B}[4;61H  \u{08}\u{08}─\u{1B}[4;63H  \u{08}\u{08}─\u{1B}[4;65H  \u{08}\u{08}─\u{1B}[4;67H  \u{08}\u{08}─\u{1B}[4;69H  \u{08}\u{08}─\u{1B}[4;71H  \u{08}\u{08}─\u{1B}[4;73H  \u{08}\u{08}─\u{1B}[4;75H  \u{08}\u{08}─\u{1B}[4;77H  \u{08}\u{08}─\u{1B}[4;79H\r\n\u{1B}[m\u{1B}[K\n就是阿... 我剛剛阿\u{1B}[K\r\n跟著版友們一起扮演柯南\u{1B}[K\r\n發現裡面有個大奶不知道是姐姐還是其實是女友")
        
        terminal.feed(text: "....\u{1B}[K\r\n首先版友提供的臉書\u{1B}[K\r\nhttps://www.facebook.com/wen120416\u{1B}[K\r\n\u{1B}[K\n臉書裡面的 關於我\u{1B}[K\r\nhttps://i.imgur.com/FVtXq5f.jpg\u{1B}[K\r\n\u{1B}[K\n連結到這位的FB 追蹤超多....\u{1B}[K\r\nhttps://i.imgur.com/LrFZxeY.jpg\u{1B}[K\r\n\u{1B}[K\n再從她FB裡面找到IG\u{1B}[K\r\nhttps://i.imgur.com/saMgU58.jpg\u{1B}[K\r\n\u{1B}[K\n\u{1B}[K\n然後不小心在ig裡面找到這張照片\u{1B}[K\r\nhttps://i.imgur.com/uh2NBHZ.jpg\u{1B}[K\r\n\u{1B}[33;45m  瀏覽 第 1/14 頁 (  1%) \u{1B}[1;30;47m 目前顯示: 第 01~22 行\u{1B}[0;47m \u{1B}[31m(y)\u{1B}[30m回應\u{1B}[31m(X%)\u{1B}[30m推文\u{1B}[31m(h)\u{1B}[30m說明\u{1B}[31m(  \u{08}\u{08}←\u{1B}[24;74H)\u{1B}[30m離開\u{1B}[m\u{1B}[24;80H")
        
        terminal.feed(text: "\u{1B}[H等等 這照片的取景跟視角好眼熟\u{1B}[K\r\n原來是跟剛剛鄉民這篇\u{1B}[K\r\nhttps://www.ptt.cc/bbs/Gossiping/M.1588634672.A.B67.html\u{1B}[K\r\n裡面的這張照片同個地點\u{1B}[K\r\nhttps://i.imgur.com/btoqz1gl.jpg\r\n只是把lv床單換成dior的床單....\r\n\u{1B}[K\n\u{1B}[K\n再看一次\u{1B}[K\ni.imgur.com/uh2NBHZ.jpg\u{1B}[K\r\nhttps://i.imgur.com/btoqz1gl.jpg\r\n\u{1B}[K\n這樣有掛嗎....\u{1B}[K\r\n\n--\u{1B}[K\r\n  \u{08}\u{08}\u{1B}[32m※\u{1B}[16;3H 發信站: 批踢踢實業坊(ptt.cc), 來自: 60.250.231.169 (臺灣)\r\n  \u{08}\u{08}※\u{1B}[17;3H 文章網址: https://www.ptt.cc/bbs/Gossiping/M.1588637328.A.697.html\r\n\u{1B}[0;1;37m推 \u{1B}[33mrick102233\u{1B}[0;33m: 都姓陳 樓下補                                       \u{1B}[m05/05 08:10\r\n\u{1B}[1;37m推 \u{1B}[33maaabbb111\u{1B}[0;33m: 允霏出來打球                                         \u{1B}[m05/05 08:10\r\n\u{1B}[1;37m推 \u{1B}[33mWeGoStyle\u{1B}[0;33m: 允霏好正的感覺                                       \u{1B}[m05/05 08:10\r\n\u{1B}[1;37m推 \u{1B}[33mCODDDD\u{1B}[0;33m: 家族事業哦？？                                          \u{1B}[m05/05 08:11\r\n\u{1B}[1;37m推 \u{1B}[33mwang1b")

        
        terminal.startProcess ()
        view.addSubview(terminal)
        
        logging = NSUserDefaultsController.shared.defaults.bool(forKey: "LogHostOutput")
        updateLogging ()
    }

    override func viewDidLayout() {
        super.viewDidLayout()
        changingSize = true
        terminal.frame = view.frame
        changingSize = false
        terminal.needsLayout = true
    }


    @objc @IBAction
    func set80x25 (_ source: AnyObject)
    {
        terminal.resize(cols: 80, rows: 25)
    }

    var lowerCol = 80
    var lowerRow = 25
    var higherCol = 160
    var higherRow = 60
    
    func queueNextSize ()
    {
        // If they requested a stop
        if resizificating == 0 {
            return
        }
        var next = terminal.getTerminal().getDims ()
        if resizificating > 0 {
            if next.cols < higherCol {
                next.cols += 1
            }
            if next.rows < higherRow {
                next.rows += 1
            }
        } else {
            if next.cols > lowerCol {
                next.cols -= 1
            }
            if next.rows > lowerRow {
                next.rows -= 1
            }
        }
        terminal.resize (cols: next.cols, rows: next.rows)
        var direction = resizificating
        
        if next.rows == higherRow && next.cols == higherCol {
            direction = -1
        }
        if next.rows == lowerRow && next.cols == lowerCol {
            direction = 1
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.03) {
            self.resizificating = direction
            self.queueNextSize()
        }
    }
    
    var resizificating = 0
    
    @objc @IBAction
    func resizificator (_ source: AnyObject)
    {
        if resizificating != 1 {
            resizificating = 1
            queueNextSize ()
        } else {
            resizificating = 0
        }
    }

    @objc @IBAction
    func resizificatorDown (_ source: AnyObject)
    {
        if resizificating != -1 {
            resizificating = -1
            queueNextSize ()
        } else {
            resizificating = 0
        }
    }

    @objc @IBAction
    func allowMouseReporting (_ source: AnyObject)
    {
        terminal.allowMouseReporting.toggle ()
    }
    
    @objc @IBAction
    func softReset (_ source: AnyObject)
    {
        terminal.getTerminal().softReset ()
        terminal.setNeedsDisplay(terminal.frame)
    }
    
    @objc @IBAction
    func hardReset (_ source: AnyObject)
    {
        terminal.getTerminal().resetToInitialState ()
        terminal.setNeedsDisplay(terminal.frame)
    }
    
    @objc @IBAction
    func toggleOptionAsMetaKey (_ source: AnyObject)
    {
        terminal.optionAsMetaKey.toggle ()
    }
    
    @objc @IBAction
    func addTab (_ source: AnyObject)
    {
        
//        if let win = view.window {
//            win.tabbingMode = .preferred
//            if let wc = win.windowController {
//                if let d = wc.document as? Document {
//                    do {
//                        let x = Document()
//                        x.makeWindowControllers()
//
//                        try NSDocumentController.shared.newDocument(self)
//                    } catch {}
//                    print ("\(d.debugDescription)")
//                }
//            }
//        }
//            win.tabbingMode = .preferred
//            win.addTabbedWindow(win, ordered: .above)
//
//            if let wc = win.windowController {
//                wc.newWindowForTab(self()
//                wc.showWindow(source)
//            }
//        }
    }
    
    func validateUserInterfaceItem(_ item: NSValidatedUserInterfaceItem) -> Bool
    {
        if item.action == #selector(debugToggleHostLogging(_:)) {
            if let m = item as? NSMenuItem {
                m.state = logging ? NSControl.StateValue.on : NSControl.StateValue.off
            }
        }
        if item.action == #selector(resizificator(_:)) {
            if let m = item as? NSMenuItem {
                m.state = resizificating == 1 ? NSControl.StateValue.on : NSControl.StateValue.off
            }
        }
        if item.action == #selector(resizificatorDown(_:)) {
            if let m = item as? NSMenuItem {
                m.state = resizificating == -1 ? NSControl.StateValue.on : NSControl.StateValue.off
            }
        }
        if item.action == #selector(allowMouseReporting(_:)) {
            if let m = item as? NSMenuItem {
                m.state = terminal.allowMouseReporting ? NSControl.StateValue.on : NSControl.StateValue.off
            }
        }
        if item.action == #selector(toggleOptionAsMetaKey(_:)) {
            if let m = item as? NSMenuItem {
                m.state = terminal.optionAsMetaKey ? NSControl.StateValue.on : NSControl.StateValue.off
            }
        }
        return true
    }
    
    @objc @IBAction
    func defaultFontSize  (_ source: AnyObject)
    {
        
    }
    
    @objc @IBAction
    func biggerFontSize (_ source: AnyObject)
    {
        
    }
    
    @objc @IBAction
    func smallerFontSize (_ source: AnyObject)
    {
        
    }
    
    @objc @IBAction
    func debugToggleHostLogging (_ source: AnyObject)
    {
        logging = !logging
        updateLogging()
    }
    
}

