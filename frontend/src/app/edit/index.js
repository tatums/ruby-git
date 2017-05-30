import { Component } from '@angular/core'
import { NgForm } from '@angular/forms'
import { ActivatedRoute } from '@angular/router'
import { Http } from '@angular/http'

import template from './template.html'

@Component({
  template: template,
})

export class EditComponent {
  constructor(route: ActivatedRoute, http: Http) {
    this.id = route.snapshot.data.id
    this.http = http
  }

  ngOnInit () {
    return this.http.get(`/api/edit/${this.id}`)
      .subscribe(resp => {
        let json = resp.json()
        this.body = json.article
      })
  }

  save(form, validity) {
    console.log('form', form)
  }
}
