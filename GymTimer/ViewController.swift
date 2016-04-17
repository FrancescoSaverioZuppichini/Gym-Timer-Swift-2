//
//  ViewController.swift
//  GymTimer
//
//  Created by Francesco  on 28/02/16.
//  Copyright © 2016 Francesco Saverio Zuppichini. All rights reserved.
//

import Cocoa
import AppKit

class ViewController: NSViewController,NSWindowDelegate{
    
    @IBOutlet var MainView: NSView!
    
    @IBOutlet weak var TimerLabel: NSTextField!
    @IBOutlet weak var StopButtom: NSButton!
    @IBOutlet weak var StartButtom: NSButton!
    
    var timer = NSTimer()
    var csecs = 0
    var secs = 0
    var mins = 0
    var hours = 0
    var started = false
    var reset = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /* load the first time */
        TimerLabel.stringValue = formatTimer()
        
    }
    
    override func viewWillAppear() {
        self.view.window!.delegate = self
        self.view.window!.title = "Gym Timer"
    }
    
    /* This function is called when a resize event is triggered */
    func windowWillResize(sender: NSWindow,toSize frameSize: NSSize) -> NSSize {
        /* change the font of the timer when we resize it */
        TimerLabel.font = NSFont(name: TimerLabel.font!.fontName, size: 0.16*frameSize.width)
        return frameSize
    }
    
    func windowDidResize(notification: NSNotification) {
        
    }
    
    @IBAction func StartClicked(sender: AnyObject) {
        reset = false
        StopButtom.title = "Stop"
        if(!started){
            started = true
            /* set the timer to tick every 0.1s, the action is 'updateTimer' */
            self.timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target:self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        }
        
    }
    
    @IBAction func StopClicked(sender: AnyObject) {
        started = false
        if(reset){
            /* re-set the timer */
            initializeTimer()
            /* update the text */
            TimerLabel.stringValue = formatTimer()
        }
        reset = true
        StopButtom.title = "Reset"
        self.timer.invalidate()
    }
    
    func initializeTimer(){
        csecs = 0
        secs = 0
        mins = 0
        hours = 0
    }
    
    func formatTimer() ->String{
        
        if(csecs == 100){
            csecs = 0
            secs+=1
        }
        if (secs == 60) {
            secs = 0
            mins += 1
        }
        
        if (mins == 60) {
            mins = 0
            hours += 1
        }
        /* add missing zeros */
        let strCSeconds = String(format: "%02d", csecs)
        let strSeconds = String(format: "%02d", secs)
        let strMinutes = String(format: "%02d", mins)
        let strHours = String(format: "%02d", hours)
        
        return (strHours + ":" + strMinutes + ":"  + strSeconds + "." + strCSeconds)
        
    }
    
    func updateTimer(){
        csecs += 1
        TimerLabel.stringValue = formatTimer()
    }
    
    override var representedObject: AnyObject? {
        didSet {
        }
    }
    
    
}