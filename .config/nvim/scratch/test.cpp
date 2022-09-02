


class SomeInterface
{
public:
  SomeInterface() = default;
  SomeInterface(SomeInterface &&) = delete;
  SomeInterface(const SomeInterface &) = delete;
  SomeInterface &operator=(SomeInterface &&) = delete;
  SomeInterface &operator=(const SomeInterface &) = delete;
  virtual ~SomeInterface() = default;
  virtual int someDefinition(int var) = 0;
private:
  
};


class SomeImpl : public SomeInterface{
  public:
};
