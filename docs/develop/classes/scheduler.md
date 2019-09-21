# The Scheduler Class

*Python SDK*

Several eGeoffrey components need to run specific tasks recurrently or at a given time. For this reason, an abstraction of the Python [ApScheduler](https://apscheduler.readthedocs.io/en/latest/userguide.html) class is provided through a `Scheduler` class. 

    Developers don't need to leverage the Scheduler class directly. This is mainly used by eGeoffrey's controller modules as well as by the `Service` class for scheduling sensors' poll actions on your behalf
 
The following functions are provided:

* `start()`: start the scheduler (otherwise will be added at the first job submission
* `stop()`: stop the scheduler
* `add_job(job)`:  schedule a new job (job is a dict in the `apscheduler` format). Returns the `job_id`
* `remove_job(job_id)`:  unschedule a job previously scheduled with `add_job`

