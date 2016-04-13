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
    var dsecs = 0
    var secs = 0
    var mins = 0
    var hours = 0
    var started = false
    var reset = false
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        TimerLabel.stringValue = formatTimer()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear() {
        self.view.window!.delegate = self
        self.view.window!.title = "Gym Timer"
    }
    
    func windowWillResize(sender: NSWindow,toSize frameSize: NSSize) -> NSSize {
        print(frameSize)
        TimerLabel.font = NSFont(name: TimerLabel.font!.fontName, size: 0.18*frameSize.width)
        return frameSize
        // Your code goes here
    }
    
    func windowDidResize(notification: NSNotification) {
        
        // Your code goes here
    }
    
    
    @IBAction func StartClicked(sender: AnyObject) {
        reset = false
        StopButtom.title = "Stop"
        if(!started){
            started = true
            self.timer = NSTimer.scheduledTimerWithTimeInterval(0.1, target:self, selector: #selector(ViewController.updateTimer), userInfo: nil, repeats: true)
        }
        
    }
    
    @IBAction func StopClicked(sender: AnyObject) {
        started = false
        if(reset){
            initializeTimer()
            TimerLabel.stringValue = formatTimer()
        }
        reset = true
        StopButtom.title = "Reset"
        self.timer.invalidate()
    }
    
    
    func initializeTimer(){
        dsecs = 0
        secs = 0
        mins = 0
        hours = 0
    }
    
    func formatTimer() ->String{
        
        if(dsecs >= 10){
            dsecs = 0
            secs+=1
        }
        if (secs >= 60) {
            secs = 0
            mins += 1
        }
        
        if (mins >= 60) {
            mins = 0
            hours += 1
        }
        
        return (formatZero(hours) + ":" + formatZero(mins) + ":"  + formatZero(secs) + "." + String(dsecs))
        
    }
    
    func formatZero(n : Int) ->String{
        return n < 10 ? "0"+String(n) : String(n)
        
    }
    
    func updateTimer(){
        dsecs += 1
        TimerLabel.stringValue = formatTimer()
    }
    
    override var representedObject: AnyObject? {
        didSet {
            // Update the view, if already loaded.
        }
    }
    
    
}