===============================================
Cloud Computing, Virtualization, and Automation
===============================================

Cloud Computing
---------------

"Cloud computing," in many (all?) ways is really a development of
marketing rather than technology. While there are new technologies
that are more prominent and patterns (both technical and business)
that are more prevalent "in the cloud," the deeper you delve into
"cloud technology," the more the technology seems *really old*.

There are a lot of components that make up cloud technology, but this
document will assume the following basic components of "the cloud:"

- Computing is **non-local** and the user interface is a *thin* layer
  on top of a more robust set of APIs.

  As a corollary, the actual computing instruments that people handle
  have shrunk in size and in computing power (see: smart phones and
  tablets.)

- Vendors provide technology as a *resource* and *service* rather than
  a *product*. This affects both delivery and billing, and is true at
  all layers of the stack: from network and "hosting" services to
  user-facing applications.

  As a corollary multi-tenancy, particularly vis-a-vis operating
  system level virtualization (i.e. Xen, KVM, VMWare,) has provided
  technology firms with an avenue to control costs.

- Open source, at least insofar as permissive licensing and access
  drives adoption, reigns.

- Network connections are universal and assumed as a prerequisite for
  any computing activity.

While these technologies and patterns are *real*, and have shaped and
reshaped the way that the technology industry operates and does
business, it's remarkably similar to a series of other "revolutions in
computing," over the past 30 years or so. Consider:

- "SOA," (server oriented architecture) which was a application design
  paradigm in the 90s which defined a high level approach to
  interoperability, is pretty much the same thing as non-local
  computing with robust APIs. Swap out REST and HTTP with JSON for
  XML-RPC, and replace business driven design process with a more
  developer centric design process, and you have something that looks
  a lot like "cloud applications and services."

- Operating System level virtualization is just the latest iteration
  on a long series of developments around multi-user operating
  systems, and process sand boxing. UNIX in the 80s, the JVM in the
  90s, and so forth.

- Thin-client computing, be it dumb terminals and Sun's "SunRay"
  clients or iPads and Android phones have a lot in common with
  regard, to application design, and the distribution of computing
  resources. Android/iOS devices are less specifically coupled to
  their servers, and are likely "thicker," by comparison, but "old
  school thin computing," had it's heyday 15 or 20 years ago, so the
  comparison will always be rough.

- The shift from "paying for software licenses," to "paying for
  services," as the primary technology related transaction, may seem
  like a big deal for the technology industry, but licenses are no
  more a mystification on actual cost than the service formula, and in
  many ways, the re-characterization of technology spending as
  "service"-based rather than "property"-based is likely a move
  towards a more authentic economic transaction. [#services]_

In the end cloud computing is really just a new collection of
buzzwords and framework for thinking about the same kinds of
technological questions that systems administrators have been
addressing for the last 30 years. The content of this resource
addresses concerns relevant to all kinds of systems administrators
regardless of environment. Nevertheless, there are some special
considerations for those working with cloud computing that systems
administrators be aware of when designing architectures for
deployments and communicating with vendors and developers, and this
article addresses some of these issues.

.. [#services] At the same time the systems architecture needs to, at
   least in some senses, reflect the economics of the
   technology. While this is an easy ideology to subscribe to, it's
   incredibly difficult to implement, at different levels of "the
   stack," and with a great deal of existing technology. If you use
   ephemeral infrastructure, then all layers of your application stack
   must be able to operate (and presumably remain available) on
   infrastructure that stops, restarts, and fails without warning.

Virtualization
--------------

Production ready virtualization technology for commodity hardware is
likely point at which "cloud" computing began. Certainly
virtualization isn't new: virtualization has been common on mainframes
for decade, and while x86 systems have had some virtualization
tools, until 2004 or even 2007 virtualization technology wasn't
"production ready."

With robust open source hypervisors like Xen and KVM (and to a lesser
extend UML and FreeBSD-style "jails" or "containers") it became
possible to fully disassociate the systems and configuration
(i.e. "instances,") that provide services from actual
hardware. Furthermore, with simple APIs and a thin management layer,
it became feasible (and profitable!) for vendors to sell access to
virtual instances. The "cloud" makes it possible to disconnect the
price and challenge of doing things with technology from the project
of managing, operating, and maintaining physical machines.

Managing physical machines is still a challenge, and there is a lot of
administrative work that, but rather than having "general practice"
systems administrators who are responsible for applications,
databases, also responsible for the provisioning and management of
hardware, dedicated administrators with experience related to hardware
and "infrastructure" management (i.e. networking, hypervisors, etc.)
Additionally, managing a dozens or hundreds (or more!) identical
systems with nearly identical usage profiles, is considerably easier
than managing a much smaller number of machines with varied usage
profiles and configurations.

Increasingly the umbrella "cloud" refers to services that fall outside
of the original "infrastructure," services and includes entire
application stacks (i.e. "platforms,") and user-facing
applications. But virtualization and "infrastructure" services has
created and/or built upon a "culture of outsourcing," that makes all
of these other cloud services possible. Infrastructure services allow
developers and administrators the flexibility to develop and deploy
applications, while controlling all infrastructure costs
(i.e. monetary and management related.)

The Technology
~~~~~~~~~~~~~~

- xen,
- management apis

The Service
~~~~~~~~~~~

how to use cloud services, and how to get the most out of cloud
services you have to think like a vendor, and their business model and
make sure that your application and its usage pattern is compatible.

performance variation.

thoughts on a

Outsourcing and Vendor Relationships
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

- contracts.
- availability.

Configuration Management
------------------------

Approaches
~~~~~~~~~~

- Configuration enforcement and updating.
- Templating.

Products
~~~~~~~~

- vagrant
- Chef
- Puppet
- BCFG
- make

Strategy
~~~~~~~~

build-destroy-deploy
ephemeral/statelessness/non-persistence

