import { Component, OnInit, Input } from '@angular/core';
import { ActivatedRoute } from '@angular/router';
import { Location } from '@angular/common';

import { Job } from '../job';
import { JobService }  from '../job.service';

@Component({
  selector: 'app-job-detail',
  templateUrl: './job-detail.component.html',
  styleUrls: ['./job-detail.component.css']
})
export class JobDetailComponent implements OnInit {
  @Input() job: Job;

  constructor(
    private route: ActivatedRoute,
    private jobService: JobService,
    private location: Location) { }

  ngOnInit() {
    this.getjob();
  }

  getjob(): void {
    const job_id = +this.route.snapshot.paramMap.get('job_id');
    this.jobService.getJob(job_id)
      .subscribe(job => this.job = job);
  }
  
  goBack(): void {
    this.location.back();
  }
}
