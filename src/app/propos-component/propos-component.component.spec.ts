import { async, ComponentFixture, TestBed } from '@angular/core/testing';

import { ProposComponentComponent } from './propos-component.component';

describe('ProposComponentComponent', () => {
  let component: ProposComponentComponent;
  let fixture: ComponentFixture<ProposComponentComponent>;

  beforeEach(async(() => {
    TestBed.configureTestingModule({
      declarations: [ ProposComponentComponent ]
    })
    .compileComponents();
  }));

  beforeEach(() => {
    fixture = TestBed.createComponent(ProposComponentComponent);
    component = fixture.componentInstance;
    fixture.detectChanges();
  });

  it('should create', () => {
    expect(component).toBeTruthy();
  });
});
