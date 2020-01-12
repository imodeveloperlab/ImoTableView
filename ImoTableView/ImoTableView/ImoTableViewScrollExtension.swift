//
//  ImoTableViewActions.swift
//  ImoTableView
//
//  Created by Borinschi Ivan on 5/7/17.
//  Copyright © 2017 Imodeveloperlab. All rights reserved.
//

import UIKit

public extension ImoTableView {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let closure = self.scrollViewDidScroll {
            closure(scrollView)
        }
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        if let closure = self.scrollViewDidZoom {
            closure(scrollView)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        if let closure = self.scrollViewWillBeginDragging {
            closure(scrollView)
        }
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if let closure = self.scrollViewWillEndDragging {
            closure(scrollView, velocity, targetContentOffset)
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if let closure = self.scrollViewDidEndDragging {
            closure(scrollView, decelerate)
        }
    }
    
    func scrollViewWillBeginDecelerating(_ scrollView: UIScrollView) {
        if let closure = self.scrollViewWillBeginDecelerating {
            closure(scrollView)
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if let closure = self.scrollViewDidEndDecelerating {
            closure(scrollView)
        }
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        if let closure = self.scrollViewDidEndScrollingAnimation {
            closure(scrollView)
        }
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        if let closure = self.viewForZooming {
            return closure(scrollView)
        }
        
        return nil
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        if let closure = self.scrollViewWillBeginZooming {
            closure(scrollView, view)
        }
    }
    
    func scrollViewDidEndZooming(_ scrollView: UIScrollView, with view: UIView?, atScale scale: CGFloat) {
        if let closure = self.scrollViewDidEndZooming {
            closure(scrollView, view, scale)
        }
    }
    
    func scrollViewShouldScrollToTop(_ scrollView: UIScrollView) -> Bool {
        if let closure = self.scrollViewShouldScrollToTop {
            return closure(scrollView)
        }
        return true
    }
    
    func scrollViewDidScrollToTop(_ scrollView: UIScrollView) {
        if let closure = self.scrollViewDidScrollToTop {
            closure(scrollView)
        }
    }
}
