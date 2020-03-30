import { Component, ViewChild, HostListener, ElementRef, AfterViewInit  } from '@angular/core';
import { MatToolbar } from '@angular/material/toolbar';
import { MatSidenav } from '@angular/material/sidenav';
import { FormControl, Validators, FormGroup } from '@angular/forms';

import 'jarallax';
declare var jarallax: any;
@Component({
  selector: 'app-root',
  templateUrl: './app.component.html',
  styleUrls: ['./app.component.css']
})
export class AppComponent {
  title = 'project';
  opened = true;
  sticky: boolean = false;
  
  @ViewChild('sidenav', { static: true }) sidenav: MatSidenav;
  //@ViewChild('toolbar', { static: true }) toolbar:  ElementRef;
  barPosition: any;
/*ngAfterViewInit(){
    this.barPosition = this.barElement.nativeElement;
}*/
  ngOnInit() {
    console.log(window.innerWidth)
    if (window.innerWidth < 768) {
      this.sidenav.fixedTopGap = 55;
      this.opened = false;
    } else {
      this.sidenav.fixedTopGap = 65;
      this.opened = true;
    }
  }
  ngAfterViewInit() {
    jarallax(document.querySelectorAll('.jarallax'), {
      speed: 0.2
    });
  }
  @HostListener('window:resize', ['$event'])
  onResize(event) {
    if (event.target.innerWidth < 768) {
      this.sidenav.fixedTopGap = 55;
      this.opened = false;
    } else {
      this.sidenav.fixedTopGap = 65;
      this.opened = true;
    }
  }

  isBiggerScreen() {
    const width = window.innerWidth || document.documentElement.clientWidth || document.body.clientWidth;
    if (width < 768) {
      return true;
    } else {
      return false;
    }
  }
  @HostListener('window:scroll', ['$event'])
    handleScroll(){
        const pos = document.getElementById("tool").offsetTop;
        const windowScroll = window.pageYOffset;
       
        if(windowScroll >= pos){
            this.sticky = true;
        } else {
            this.sticky = false;
        }
    }

  }