# Using OllyStack in client work

**Short answer: yes, please.** If you're a consultant, contractor or platform team delivering
OpenTelemetry work for someone else, this is what you're allowed to do, what's asked of you, and the
one thing the licence doesn't grant.

## What you can do, without asking anyone

Under [Apache-2.0](LICENSE):

- Run this collector in production, at any scale, for any number of clients.
- Design pipelines in the portal, download the bundle, and hand it to a client as your own
  deliverable.
- Fork this repository and rebuild with your own component set.
- Modify anything, and keep your modifications private.
- **Charge your client for the work you do with it.** Your time is yours.

No notice to me, no permission, no revenue share. That is what the licence means, and it isn't
grudging — a tool that only its author can use commercially isn't much of a tool.

## What's asked, but not required

**Attribution — for the client's sake more than mine.**

If a collector config, deploy bundle or pipeline you delivered started here, leave a trace somewhere
the *next* person will find it: a line in the runbook, a comment left in the config, a sentence in
the handover doc.

The reason is practical. Your client inherits this pipeline. In eight months they'll need to absorb
a breaking collector release, and you may not be there. "This came from OllyStack, and upgrades are
documented at ollystack.com" is the difference between a maintainable pipeline and mystery YAML that
nobody dares touch.

Generated bundles already carry a header naming the version and where they came from. **Leaving that
header in is the entire ask.**

## The one thing the licence does not grant

Apache-2.0 **§6 grants no trademark rights**. The OllyStack name and logo aren't covered by it.

**Not OK**

- Naming your service, product or company OllyStack, or anything confusable with it.
- Implying that I built, reviewed, endorsed, support or am otherwise involved in your engagement.
- Presenting a rebuild of this image under the OllyStack name.

**Perfectly OK**

- "Built with OllyStack."
- "Based on the OllyStack collector distribution."
- "Pipeline designed in OllyStack, deployed and operated by us."

The distinction is simple: describing what you used is accurate, and welcome. Borrowing the name for
your own offering isn't.

## If you're delivering client work with this — two offers

**Open an issue when it doesn't do what you need.** You're using it in anger on real fleets, which is
information I don't otherwise have. A gap you hit is one your next three clients will hit too, and
fixing it probably helps you more than it helps me.

**The ongoing half isn't in this repository.** Fleet health, convergence, version-bump pull requests,
adaptive sampling and cardinality tuning run on a control plane that isn't open source and can't be
rebuilt from what's here. If a client needs that, you have better options than reimplementing it:
a referral, a subcontract, or a control plane provisioned inside the client's own environment with
you operating it. Ask — I would much rather work alongside you than watch you rebuild it badly under
deadline.

## Contributing

Contributions are welcome and need a **Developer Certificate of Origin** sign-off — `git commit -s`,
confirming you have the right to submit the work. This keeps provenance clean while copyright is
still simple; it costs you one flag and saves everyone a relicensing problem later.

---

Questions about any of this, or a case it doesn't cover: <mbeema@sloan.mit.edu>.
