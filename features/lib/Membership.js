class Membership {
  constructor({ space, member }) {
    this.space = space;
    this.member = member;
  }
  asParams() {
    return {
      spaceId: this.space.id,
      memberId: this.member.id,
    };
  }
}
export default Membership;
