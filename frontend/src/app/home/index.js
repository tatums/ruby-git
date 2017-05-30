import { Component } from '@angular/core'
import template from './template.html'
import { Http } from '@angular/http'

@Component({
  template: template,
})

export class HomeComponent {

  constructor(http: Http) {
    this.http = http
  }

  ngOnInit () {
    return this.http.get('/api/')
      .subscribe(resp => {
        this.repo = resp.json()
        console.log(resp.json());
      })
  }
}
